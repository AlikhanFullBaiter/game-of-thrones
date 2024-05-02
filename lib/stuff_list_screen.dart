import 'package:flutter/material.dart';

class StuffListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Stuff'),
      ),
      body: ListView(
        children: [
          buildStuffItem(context, 'assets/img/', 'John Doe', 'Developer'),
          buildStuffItem(
              context, 'assets/images/stuff2.jpg', 'Jane Smith', 'Designer'),
          buildStuffItem(
              context, 'assets/images/stuff3.jpg', 'Mike Johnson', 'Manager'),
          // Add more stuff items as needed
        ],
      ),
    );
  }

  Widget buildStuffItem(
      BuildContext context, String imagePath, String name, String position) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
      ),
      title: Text(name),
      subtitle: Text('Position: $position'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StuffDetailScreen(name),
          ),
        );
      },
    );
  }
}

class StuffDetailScreen extends StatelessWidget {
  final String stuffName;

  StuffDetailScreen(this.stuffName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stuff Detail'),
      ),
      body: Center(
        child: Text(stuffName),
      ),
    );
  }
}
