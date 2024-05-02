import 'package:flutter/material.dart';

class ActorsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Actors'),
      ),
      body: ListView(
        children: [
          buildActorItem(
              context,
              'assets/img/harington.jpg',
              'Kit Harington',
              'Jon Snow',
              'Kit Harington is a British actor best known for his role as Jon Snow in the Game of Thrones series. He was born on December 26, 1986, in Acton, London. Harington studied acting at the Royal Central School of Speech & Drama, graduating in 2008.'),
          // Add more actors
        ],
      ),
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
