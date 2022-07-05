import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FileOne extends StatefulWidget {
  const FileOne({Key? key}) : super(key: key);

  @override
  State<FileOne> createState() => _FileOneState();
}

class _FileOneState extends State<FileOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fetch Data From internet"),
        centerTitle: true,
      ),
      // body: ListView.builder(itemBuilder: itemBuilder)
    );
  }
}
