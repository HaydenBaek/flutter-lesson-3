import 'package:flutter/material.dart';
import 'api.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyStateFullApp();
}

class MyStateFullApp extends State<MyApp> {
  String _postId = '';
  String _id = '';

  Message? _message;
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Message postId"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _postId = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Message id"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _id = value;
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                try {
                  final msg = await getNews(_id, _postId);
                  setState(() {
                    _message = msg;
                    _error = '';
                  });
                } catch (e) {
                  setState(() {
                    _message = null;
                    _error = e.toString();
                  });
                }
              },
              child: const Text("Get Message"),
            ),
            const SizedBox(height: 16),
            if (_error.isNotEmpty)
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Error: $_error"),
              ),
            if (_message != null) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Name: ${_message!.name}"),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Email: ${_message!.email}"),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Body: ${_message!.body}"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
