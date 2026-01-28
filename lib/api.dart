import 'dart:convert';
import 'package:http/http.dart' as http;

class Message {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Message({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });
}

Future<Message> getNews(String id, String postID) async {
  String url = "https://jsonplaceholder.typicode.com/comments?postId=$postID&id=$id";

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'User-Agent': 'MyFlutterApp/1.0 (Flutter; Android)',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);   // List
    var singleResponse = responseData[0];           // first item (Map)

    // Put breakpoint on the next line for part (a)
    Message msg = Message(
      postId: singleResponse['postId'],
      id: singleResponse['id'],
      name: singleResponse['name'],
      email: singleResponse['email'],
      body: singleResponse['body'],
    );

    return msg;
  } else {
    final errorMessage =
        'Failed to get message. Error: ${response.statusCode} - ${response.body}';
    throw Exception(errorMessage);
  }
}
