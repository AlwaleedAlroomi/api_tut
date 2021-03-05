import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  static const String _baseUrl = "http://10.0.2.2:8000/api/posts/";
  int id;
  String title, content, photo;

  Post({this.title, this.content, this.id, this.photo});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        photo: json['photo'],
      );
  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'content': content};

  static Future<http.Response> createPost(Post post) async {
    final http.Response response = await http.post(
      _baseUrl,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWEyNWIwMzVjMmUxOWQ2NDVjZGVmYmYzYTMyZDQ4MjgyYTg4YWYwYTVmMDAzYTE1NGRjNDRlN2U3NmMwZDUwZGE5ZTJkYzg4NWExMWUyMWUiLCJpYXQiOiIxNjEyMzMwNzc5LjIxNzMwNyIsIm5iZiI6IjE2MTIzMzA3NzkuMjE3MzEwIiwiZXhwIjoiMTY0Mzg2Njc3OS4yMDI2MzkiLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.pbe2ysbrODHixTMlP4V0N9wxP-UtbXjqBWROyWhC3eecv1LylH234lrTCepcfFRFDjD-8LWLCDDXDhyZABBzoTe_WL2-cE75-rUr8-LhI0czopirNrjOuLz6zjg_TjtOjADKYAq9KLQXoc3oj0p8TbPPW3xn3cDBQQYfhzi0RzwqN02CpBq8MuG7uNR1qhHMXePGYZCx45FwSLW7-HXjy8-xO5IGDPVN1ddtHdM3hZd2-TTwuy4_jmYJJzsfPVpp61X2C_1QXoqjeZFTf4X7NMVd8PJTR6Xphig-5JUTC4nLHHYo8J1RmrDEdw7evre9RruuYhmsfLbknCzrPwUahV5jQNiN8RokDQaHV1U-kPGGeGZv5RB9DoENMELjJisYCEF-JX2jh82aacos1tzi6zIc5JGW35HoR02iLzro2URQjOdQ62civMr1jkJYY0U3YgEc0FwMtIfwC5im1tGIedrsmBqOeii_bfEP4Lq03JqsuzyR9FU4n5fApb2ucR-dq0EuwZklyLp3ZNUQGjCWwqhe7LxabihlXGinG72Rb_UFsWl4-l7U7-wHww2RhXXGsS1G-0jwRIy1Y-BkgqhAKnilX7x0WvILZaJ1wDto02PWsX2WunO0E8jSctMPWfyh6NrHdSqjJu-g3r4QOeg0EpMRDNMJI6PmB3XKCwrimYI'
      },
      body: jsonEncode(
        post.toJson(),
      ),
    );
    if (response.statusCode == 200) {
      print(response.body);
      // return Post.fromJson(json.decode(response.body));
    } else {
      print('error');
    }
    return response;
  }

  static Future<http.Response> deletePost(int id) async {
    final http.Response response = await http.delete(
      "$_baseUrl$id",
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWEyNWIwMzVjMmUxOWQ2NDVjZGVmYmYzYTMyZDQ4MjgyYTg4YWYwYTVmMDAzYTE1NGRjNDRlN2U3NmMwZDUwZGE5ZTJkYzg4NWExMWUyMWUiLCJpYXQiOiIxNjEyMzMwNzc5LjIxNzMwNyIsIm5iZiI6IjE2MTIzMzA3NzkuMjE3MzEwIiwiZXhwIjoiMTY0Mzg2Njc3OS4yMDI2MzkiLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.pbe2ysbrODHixTMlP4V0N9wxP-UtbXjqBWROyWhC3eecv1LylH234lrTCepcfFRFDjD-8LWLCDDXDhyZABBzoTe_WL2-cE75-rUr8-LhI0czopirNrjOuLz6zjg_TjtOjADKYAq9KLQXoc3oj0p8TbPPW3xn3cDBQQYfhzi0RzwqN02CpBq8MuG7uNR1qhHMXePGYZCx45FwSLW7-HXjy8-xO5IGDPVN1ddtHdM3hZd2-TTwuy4_jmYJJzsfPVpp61X2C_1QXoqjeZFTf4X7NMVd8PJTR6Xphig-5JUTC4nLHHYo8J1RmrDEdw7evre9RruuYhmsfLbknCzrPwUahV5jQNiN8RokDQaHV1U-kPGGeGZv5RB9DoENMELjJisYCEF-JX2jh82aacos1tzi6zIc5JGW35HoR02iLzro2URQjOdQ62civMr1jkJYY0U3YgEc0FwMtIfwC5im1tGIedrsmBqOeii_bfEP4Lq03JqsuzyR9FU4n5fApb2ucR-dq0EuwZklyLp3ZNUQGjCWwqhe7LxabihlXGinG72Rb_UFsWl4-l7U7-wHww2RhXXGsS1G-0jwRIy1Y-BkgqhAKnilX7x0WvILZaJ1wDto02PWsX2WunO0E8jSctMPWfyh6NrHdSqjJu-g3r4QOeg0EpMRDNMJI6PmB3XKCwrimYI'
      },
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      print('error');
    }
  }

  static Future<http.Response> updatePost(Post post) async {
    final http.Response response = await http.put(
      "$_baseUrl${post.id}",
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWEyNWIwMzVjMmUxOWQ2NDVjZGVmYmYzYTMyZDQ4MjgyYTg4YWYwYTVmMDAzYTE1NGRjNDRlN2U3NmMwZDUwZGE5ZTJkYzg4NWExMWUyMWUiLCJpYXQiOiIxNjEyMzMwNzc5LjIxNzMwNyIsIm5iZiI6IjE2MTIzMzA3NzkuMjE3MzEwIiwiZXhwIjoiMTY0Mzg2Njc3OS4yMDI2MzkiLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.pbe2ysbrODHixTMlP4V0N9wxP-UtbXjqBWROyWhC3eecv1LylH234lrTCepcfFRFDjD-8LWLCDDXDhyZABBzoTe_WL2-cE75-rUr8-LhI0czopirNrjOuLz6zjg_TjtOjADKYAq9KLQXoc3oj0p8TbPPW3xn3cDBQQYfhzi0RzwqN02CpBq8MuG7uNR1qhHMXePGYZCx45FwSLW7-HXjy8-xO5IGDPVN1ddtHdM3hZd2-TTwuy4_jmYJJzsfPVpp61X2C_1QXoqjeZFTf4X7NMVd8PJTR6Xphig-5JUTC4nLHHYo8J1RmrDEdw7evre9RruuYhmsfLbknCzrPwUahV5jQNiN8RokDQaHV1U-kPGGeGZv5RB9DoENMELjJisYCEF-JX2jh82aacos1tzi6zIc5JGW35HoR02iLzro2URQjOdQ62civMr1jkJYY0U3YgEc0FwMtIfwC5im1tGIedrsmBqOeii_bfEP4Lq03JqsuzyR9FU4n5fApb2ucR-dq0EuwZklyLp3ZNUQGjCWwqhe7LxabihlXGinG72Rb_UFsWl4-l7U7-wHww2RhXXGsS1G-0jwRIy1Y-BkgqhAKnilX7x0WvILZaJ1wDto02PWsX2WunO0E8jSctMPWfyh6NrHdSqjJu-g3r4QOeg0EpMRDNMJI6PmB3XKCwrimYI'
      },
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 200) {
      print('post updated succefully');
    } else {
      print('error');
    }
  }
}
