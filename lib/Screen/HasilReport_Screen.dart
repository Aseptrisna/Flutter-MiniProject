import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mini_project/Server/Server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HasilReport extends StatelessWidget {
  final String apiUrl = UrlServer + "report/get";
  Future<List<dynamic>> _fecthDataUsers() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String GUID = pref.getString('guid_id');
    final result = await http.post(Uri.parse(apiUrl), body: {"GUID": GUID});
    print(result.body);
    return json.decode(result.body)['report'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Report Anda'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: _fecthDataUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    // return ListTile(
                    //   leading: CircleAvatar(
                    //     radius: 50,
                    //     backgroundImage: NetworkImage("http://pasar.pptik.id/" +
                    //         snapshot.data[index]['IMAGE']),
                    //   ),
                    //   title: Text(snapshot.data[index]['NAME'] +
                    //       " " +
                    //       snapshot.data[index]['ADDRESS']),
                    //   subtitle: Text(snapshot.data[index]['DESCRIPTION']),
                    // );
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 1.0,
                              child: Image.network("http://pasar.pptik.id/" +
                                  snapshot.data[index]['IMAGE']),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    5.0, 0.0, 2.0, 0.0),
                                child: ListTile(
                                  title: Text(
                                    snapshot.data[index]['NAME'],
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal),
                                  ),
                                  subtitle: Text(snapshot.data[index]
                                          ['ADDRESS'] +
                                      "" +
                                      "            " +
                                      "Deskripsi:" +
                                      snapshot.data[index]['DESCRIPTION']),

                                  // Text(),

                                  // author: author,
                                  // publishDate: publishDate,
                                  // readDuration: readDuration,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
