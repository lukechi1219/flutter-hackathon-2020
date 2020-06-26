import 'package:flutter/material.dart';

class Notify extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView(
          //TODO: Get Notify Message
      children: <Widget>[
        NotifyBuild(icon: Icons.mail, title: "title", content: "content")
      ],
    ));
  }
}

class NotifyBuild extends StatelessWidget {
  const NotifyBuild({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.content,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(content),
      ),
    );
  }
}
