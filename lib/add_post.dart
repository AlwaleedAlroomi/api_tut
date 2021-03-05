import 'package:apitut/api.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  String postContent, postTitle;
  final addpost = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: addpost,
      appBar: AppBar(
        title: Text('Add a post'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Post name',
                  hintText: 'Enter Post name',
                ),
                onChanged: (value) {
                  setState(() {
                    postTitle = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Post content',
                  hintText: 'Enter Post content',
                ),
                onChanged: (value) {
                  setState(() {
                    postContent = value;
                  });
                },
              ),
              RaisedButton(
                child: Text('save'),
                onPressed: () {
                  //send data to server
                  Post.createPost(Post(title: postTitle, content: postContent));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
