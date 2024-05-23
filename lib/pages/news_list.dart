import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class News {
  final String title;
  final String description;
  final String image;

  News({required this.title, required this.description, required this.image});
}

class NewsList extends StatefulWidget {
  static String route = 'news';
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<News> _news = [];
  bool loading = true;
  Future<bool> isExist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> news = prefs.getStringList('news') ?? [];
    if (news.isEmpty) {
      return false;
    } else {
      _news = news.map((e) {
        var item = e.split(',');
        return News(title: item.first, description: item[1], image: item[2]);
      }).toList();
      return true;
    }
  }

  Future getNews() async {
    bool exists = await isExist();
    if (!exists) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var result = await FirebaseFirestore.instance.collection('news').get();
      List<News> news = result.docs
          .map((e) => News(
              title: e['title'],
              description: e['description'],
              image: e['image']))
          .toList();
      _news = news;
      await prefs.setStringList('news',
          _news.map((e) => '${e.title},${e.description},${e.image}').toList());
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    await getNews();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News')),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                  itemCount: _news.length,
                  itemBuilder: (context, index) {
                    var item = _news[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      color: Colors.transparent,
                      elevation: 0,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (index != 0) Divider(),
                            Text(item.title,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w800)),
                            Text(item.description,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87)),
                            SizedBox(height: 15),
                            SizedBox(
                                height: 300,
                                child: Image.network(item.image,
                                    fit: BoxFit.cover)),
                          ]),
                    );
                  }),
            ),
    );
  }
}
