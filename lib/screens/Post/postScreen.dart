import 'package:flutter/material.dart';
import 'package:microblog/screens/Post/Wigets/PostagemWigets.dart';

class PostScreen extends StatefulWidget {
  PostScreen({Key key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Publicação"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xff00acee),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              PostagemWigets(),
            ],
          ),
        ),
      ),
    );
  }
}
