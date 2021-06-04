import 'package:flutter/material.dart';

class BottonBar extends StatefulWidget {
  const BottonBar({Key key}) : super(key: key);

  @override
  _BottonBarState createState() => _BottonBarState();
}

class _BottonBarState extends State<BottonBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.grey[200],
      child: Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.grey[600],
                size: 30,
              ),
              onPressed: () {}),
          Spacer(flex: 5),
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.grey[600],
                size: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/search");
              }),
          Spacer(flex: 5),
          IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.grey[600],
                size: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/notificacoes");
              }),
          Spacer(flex: 5),
          IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.grey[600],
                size: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/accountScreen");
              }),
        ],
      ),
    );
  }
}
