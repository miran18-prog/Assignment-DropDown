import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:working_with_api/models/posts.dart';
import 'package:working_with_api/services/fetch_data.dart';

class FileOne extends StatefulWidget {
  const FileOne({Key? key}) : super(key: key);

  @override
  State<FileOne> createState() => _FileOneState();
}

class _FileOneState extends State<FileOne> {
  KurdishNameServices _kurdishNameServices = KurdishNameServices();
  String initValue = "Male";
  List<String> gender = ["Male", "Female"];
  int initLimit = 5;
  List<int> limit = [5, 10, 20, 30];
  String gV = "M";
  List<String> pnList = ["positive", "negative"];
  String initPn = "positive";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kurdish Name List"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: DropdownButton<String>(
                    value: initValue,
                    items: gender.map((g) {
                      if (initValue == "Male") {
                        gV = "M";
                      } else {
                        gV = "F";
                      }
                      return DropdownMenuItem(
                        value: g,
                        child: Text(g),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        initValue = newValue!;
                      });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: DropdownButton<String>(
                    value: initPn,
                    items: pnList.map((g) {
                      if (initPn == "positive") {
                        initPn = "positive";
                      } else {
                        initPn = "negative";
                      }
                      return DropdownMenuItem(
                        value: g,
                        child: Text(g.toString()),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        initPn = newValue!;
                      });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: DropdownButton<int>(
                    value: initLimit,
                    items: limit.map((g) {
                      return DropdownMenuItem(
                        value: g,
                        child: Text(g.toString()),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        initLimit = newValue!;
                      });
                    }),
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: FutureBuilder<KurdishNames>(
                  future: _kurdishNameServices.fetchListNames(
                      gV, initLimit.toString(), initPn),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.data == null) {
                      return Text("no Data");
                    } else {
                      return ListView.builder(
                          itemCount: initLimit,
                          itemBuilder: (context, i) {
                            return ExpansionTile(
                              title: Text(snapshot.data!.names[i].name),
                              children: [
                                Text(snapshot.data!.names[i].desc),
                              ],
                            );
                          });
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
