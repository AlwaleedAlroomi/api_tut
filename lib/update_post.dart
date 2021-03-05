import 'package:apitut/api.dart';
import 'package:flutter/material.dart';

class UpdatePost extends StatefulWidget {
  final Post post;
  UpdatePost(this.post);
  @override
  _UpdatePostState createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  String postContent, postTitle;
  @override
  void initState() {
    super.initState();
    setState(() {
      postTitle = widget.post.title;
      postContent = widget.post.content;
    });
  }

  final updatepost = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: updatepost,
      appBar: AppBar(
        title: Text('Update a post'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Post name',
                  hintText: '$postTitle',
                ),
                onChanged: (value) {
                  setState(() {
                    if (value.isNotEmpty) {
                      postTitle = value;
                    }
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Post content',
                  hintText: '$postContent',
                ),
                onChanged: (value) {
                  setState(() {
                    if (value.isNotEmpty) {
                      postContent = value;
                    }
                  });
                },
              ),
              RaisedButton(
                child: Text('Update'),
                onPressed: () {
                  //send data to server
                  widget.post.title = postTitle;
                  widget.post.content = postContent;
                  Post.updatePost(widget.post);
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
