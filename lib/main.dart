import 'package:apitut/add_post.dart';
import 'package:apitut/api.dart';
import 'package:apitut/update_post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Post>> postData;

  @override
  void initState() {
    super.initState();
    setState(() {
      postData = getData();
    });
  }

  //http://10.0.2.2:8000/
  Future<List<Post>> getData() async {
    String myUrl = "https://aqueous-mountain-60055.herokuapp.com/";
    http.Response posts = await http.get(myUrl, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      //   'Authorization':
      //       'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZGQ3NWY2MWViNmI3OGE4ODk4ZGNiNzNjYmYxNzU1ZTdhOTk0MzdjMWNiYTI3MjJmYzAzNmYwMDg2NGExZGI5OTdlYjZjMDY1YjQ4MjkxYTUiLCJpYXQiOiIxNjEzMDI1NTgyLjkzNTE3NCIsIm5iZiI6IjE2MTMwMjU1ODIuOTM1MTc4IiwiZXhwIjoiMTY0NDU2MTU4Mi45MjIwMTgiLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.cWibb4UICPj0-K0rouNN6Zl7f0d6CRL5fbcmK1xGoYAKhdERocaLJfU_eTYa1QkXQeOJeVVi9kgWWNYLfbnIksgm1YmYRqds2Hs1prASJE07U3hN_vu4x5b5a-3A2gHbA0olooil_Dwn1eNDniQ1ThvH7_xOju37uDP3iObpDKQEYZdMp8vA3kyfnvhSndpJYxTummjHWqrgxsuhlWVCiP97nUa_hwvU5TyFNZW2hM_ssjR4QjZARR0Ri86euJEwCO48BvBDVPT2O1Wgg39a2SW8YSRjvTaAEIKr93EGzYnT8I1O4zKbsIyYWXOYJcoyDBUcdz9B7G8Iqu4QCoPnl4ZnLYyk8yXR9s9qb7AfnTmM2Z_mMi48SiQ28HfKWLBNq0wSHcelMStg5CusrY9m45Po3aFF0ZSMEUsXPnv_FctNJTctbToXSur4zAW40fpbdmp5uy3EUyFS0pqrkm8Z18uwc0fL1zv3OPm-rLiqjfyt7HaRSUoyL-MpOgy0shyzjbma6XpKGGxRPYUVuyFtqUCGR9Hkc3FAJfCmO93467CeH4V_ohSaVrbpD3eTjUeC2WFjWVWW1CAQhV0fZR0mf6c4TE5oaaTFeGhq_1yuF78Aadr5xoiWkqFNTy4wV0EiEWlSfxqtpXIMntZk3WVYzh1L5Yg1cX7GAT8RXdK-ltA'
    });
    if (posts.statusCode == 200) {
      print(posts.body);
      var responseJson = json.decode(posts.body);
      return (responseJson['data'] as List)
          .map((p) => Post.fromJson(p))
          .toList();
    } else {
      throw Exception('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Networking http'),
      ),
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: postData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //List<Post> posts = snapshot.data;
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return Dismissible(
                    key: ObjectKey(snapshot.data[i].id),
                    onDismissed: (direction) {
                      Post.deletePost(snapshot.data[i].id);
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(snapshot.data[i].title),
                        subtitle: Row(
                          children: <Widget>[
                            // Image.network(
                            //   '/uploads//notes//1613109065another.jpg',
                            // ),
                          ],
                        ),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UpdatePost(snapshot.data[i]),
                            ),
                          );
                          setState(() {
                            postData = getData();
                          });
                        },
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('error: ${snapshot.error.toString()}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPost(),
            ),
          );
          setState(() {
            postData = getData();
          });
        },
      ),
    );
  }
}
