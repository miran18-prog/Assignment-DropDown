import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      body: mapResponse == null
          ? Container()
          : Column(
              children: [
                Text(
                  mapResponse!["category"].toString(),
                  style: TextStyle(fontSize: 30),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: listOfFact!.length,
                  itemBuilder: (context, i) {
                    return Container(
                      child: Text(
                        listOfFact![i]["facts"].toString(),
                      ),
                    );
                  },
                )
              ],
            ),
    );
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  List? listOfFact;
  Future fetchData() async {
    String urlLink = 'https://www.thegrowingdeveloper.org/apiview?id=2';

    http.Response response;
    response = await http.get(Uri.parse(urlLink));
    if (response.statusCode == 200) {
      mapResponse = json.decode(response.body);
      listOfFact = mapResponse!["facts"];
    }
  }
}
