import 'package:flutter/material.dart';

import './terminal.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));
String ip;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terminal app"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter Ip adress",
              style: TextStyle(fontSize: 20.0),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter IP Like 198.104.22.1",
                ),
                autofocus: false,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  ip = text;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Myweb(ip: ip)),
                );
              },
              child: Text("Submit"),
            )
          ],
        )),
      ),
    );
  }
}
