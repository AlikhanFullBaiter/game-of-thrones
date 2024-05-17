import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ActorsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Actors'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('actors').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
            if (snap.hasError) {
              print(snap.error);
              return Center(child: Text('Something went wrong'));
            }

            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            print(snap.data);
            if (snap.data != null) {
              return ListView(
                children: snap.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return buildActorItem(context, data['imagePath'],
                      data['name'], data['role'], data['biography']);
                }).toList(),

                // [
                //   buildActorItem(
                //       context,
                //       snap.data(),)
                //       // 'assets/img/harington.jpg',
                //       // 'Kit Harington',
                //       // 'Jon Snow',
                //       // 'Kit Harington is a British actor best known for his role as Jon Snow in the Game of Thrones series. He was born on December 26, 1986, in Acton, London. Harington studied acting at the Royal Central School of Speech & Drama, graduating in 2008.'),
                // ],
                // children: [
                // buildActorItem(
                //     context,
                //     'assets/img/harington.jpg',
                //     'Kit Harington',
                //     'Jon Snow',
                //     'Kit Harington is a British actor best known for his role as Jon Snow in the Game of Thrones series. He was born on December 26, 1986, in Acton, London. Harington studied acting at the Royal Central School of Speech & Drama, graduating in 2008.'),
                //   buildActorItem(
                //       context,
                //       'assets/img/clarke.jpg',
                //       'Emilia Clarke',
                //       'Daenerys Targaryen',
                //       'Emilia Clarke is an English actress known for her role as Daenerys Targaryen in the Game of Thrones series. She was born on October 23, 1986, in London. Clarke attended the Drama Centre London and graduated in 2009.'),
                //   buildActorItem(
                //       context,
                //       'assets/img/dinklage.jpg',
                //       'Peter Dinklage',
                //       'Tyrion Lannister',
                //       'Peter Dinklage is an American actor known for his role as Tyrion Lannister in the Game of Thrones series. He was born on June 11, 1969, in Morristown, New Jersey. Dinklage studied acting at Bennington College, graduating in 1991.'),
                //   buildActorItem(
                //       context,
                //       'assets/img/headey.jpg',
                //       'Lena Headey',
                //       'Cersei Lannister',
                //       'Lena Headey is an English actress known for her role as Cersei Lannister in the Game of Thrones series. She was born on October 3, 1973, in Hamilton, Bermuda. Headey attended Shelley College and then went on to pursue acting.'),
                //   buildActorItem(
                //       context,
                //       'assets/img/coster-waldau.jpg',
                //       'Nikolaj Coster-Waldau',
                //       'Jaime Lannister',
                //       'Nikolaj Coster-Waldau is a Danish actor known for his role as Jaime Lannister in the Game of Thrones series. He was born on July 27, 1970, in Rudkøbing, Denmark. Coster-Waldau studied at the Danish National School of Theatre and Contemporary Dance.'),
                //   buildActorItem(
                //       context,
                //       'assets/img/williams.jpg',
                //       'Maisie Williams',
                //       'Arya Stark',
                //       'Maisie Williams is an English actress known for her role as Arya Stark in the Game of Thrones series. She was born on April 15, 1997, in Bristol, England. Williams attended Bath Dance College.'),
                //   buildActorItem(
                //       context,
                //       'assets/img/turner.jpg',
                //       'Sophie Turner',
                //       'Sansa Stark',
                //       'Sophie Turner is an English actress known for her role as Sansa Stark in the Game of Thrones series. She was born on February 21, 1996, in Northampton, England. Turner attended Warwick Prep School and later Kings High School in Warwick.'),
                //   buildActorItem(
                //       context,
                //       'assets/img/glen.jpg',
                //       'Iain Glen',
                //       'Jorah Mormont',
                //       'Iain Glen is a Scottish actor known for his role as Jorah Mormont in the Game of Thrones series. He was born on June 24, 1961, in Edinburgh, Scotland. Glen studied at the Royal Academy of Dramatic Art.'),
                //   buildActorItem(
                //       context,
                //       'assets/img/hempstead-wright.jpg',
                //       'Isaac Hempstead Wright',
                //       'Bran Stark',
                //       'Isaac Hempstead Wright is an English actor known for his role as Bran Stark in the Game of Thrones series. He was born on April 9, 1999, in Surrey, England. Wright attended Queen Elizabeth Grammar School in Faversham, Kent.'),
                //   buildActorItem(
                //       context,
                //       'assets/img/allen.jpg',
                //       'Alfie Allen',
                //       'Theon Greyjoy',
                //       'Alfie Allen is an English actor known for his role as Theon Greyjoy in the Game of Thrones series. He was born on September 12, 1986, in Hammersmith, London, England. Allen studied at Fine Arts College in Hampstead.'),
                //   // Add more actors here...
                // ],
              );
            }
            return SizedBox();
          }),
    );
  }

  Widget buildActorItem(BuildContext context, String imagePath, String name,
      String role, String biography) {
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
                ActorDetailScreen(name, role, imagePath, biography),
          ),
        );
      },
    );
  }
}

class ActorDetailScreen extends StatelessWidget {
  final String name;
  final String role;
  final String imagePath;
  final String biography;

  ActorDetailScreen(this.name, this.role, this.imagePath, this.biography);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actor Detail'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Role: $role',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Biography:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  biography,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
