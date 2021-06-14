import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Myweb extends StatefulWidget {
  String ip;
  Myweb({this.ip});
  @override
  _MywebState createState() => _MywebState(ip);
}

class _MywebState extends State<Myweb> {
  _MywebState(this.ip);
  String ip;
  String cmd;
  var result;
  var display = "";

  web(cmd) async {
    var url = "http://${ip}/cgi-bin/web.py?x=$cmd";
    var response = await http.get(Uri.parse(url));
    setState(() {
      result = response.body;
    });
    setState(() {
      display += "[root@localhost ~]# " + cmd + "\n" + result + "\n";
    });
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terminal app"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Opacity(
                opacity: 1,
                child: GestureDetector(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: Colors.grey[800],
                    child: Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.code,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Terminal",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            trailing: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                          _divider(),
                          SingleChildScrollView(
                            child: Container(
                              width: 400,
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Text(
                                display ?? "Output",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "[root@localhost ~]# ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 160,
                                height: 60,
                                padding: EdgeInsets.only(top: 4),
                                child: TextField(
                                  onChanged: (val) {
                                    cmd = val;
                                  },
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  decoration: InputDecoration(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              web(cmd);
                            },
                            child: Container(
                              child: const Text('Enter',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _divider() {
  return Container(
    child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ),
        ),
      ],
    ),
  );
}
