import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StuffListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Stuff'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('stuff').snapshots(),
          builder: (context, snap) {
            if (snap.hasError) {
              print(snap.error);
              return Center(child: Text('Something went wrong'));
            }

            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: snap.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return buildStuffItem(context, data['imagePath'], data['name'],
                    data['role'], data['description']);
              }).toList(),
            );
            // return ListView(
            //   children: [
            //     buildStuffItem(
            //         context,
            //         'assets/img/david.jpeg',
            //         'David Benioff',
            //         'Director & Writer',
            //         'David Benioff is an American writer, director, and producer. He is best known for co-creating the Game of Thrones television series based on George R.R. Martin\'s book series A Song of Ice and Fire, along with D.B. Weiss.'),
            //     buildStuffItem(
            //         context,
            //         'assets/img/db.jpeg',
            //         'D.B. Weiss',
            //         'Director & Writer',
            //         'D.B. Weiss is an American writer, director, and producer. He is best known for co-creating the Game of Thrones television series based on George R.R. Martin\'s book series A Song of Ice and Fire, along with David Benioff.'),
            //     buildStuffItem(
            //         context,
            //         'assets/img/miguel.jpeg',
            //         'Miguel Sapochnik',
            //         'Director',
            //         'Miguel Sapochnik is a British director and screenwriter. He is known for his work on several episodes of Game of Thrones, including "Battle of the Bastards" and "The Long Night."'),
            //     // Add more stuff items as needed
            //   ],
            // );
          }),
    );
  }

  Widget buildStuffItem(BuildContext context, String imagePath, String name,
      String role, String description) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
      ),
      title: Text(name),
      subtitle: Text('Role: $role'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                StuffDetailScreen(name, description, imagePath),
          ),
        );
      },
    );
  }
}

class StuffDetailScreen extends StatelessWidget {
  final String itemName;
  final String itemDescription;
  final String itemImagePath;

  StuffDetailScreen(this.itemName, this.itemDescription, this.itemImagePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stuff Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(itemImagePath),
              radius: 60,
            ),
            SizedBox(height: 20),
            Text(
              itemName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              itemDescription,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
