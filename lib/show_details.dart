// ignore: avoid_web_libraries_in_flutter
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDets extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Widget> makeListWidget(AsyncSnapshot snapshot) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String uid = auth.currentUser.uid.toString();

    return snapshot.data.documents.map<Widget>((document) {
      if ((document["uid"].toString() == uid)) {
        return Column(
          children: <Widget>[
            SizedBox(height: 200),
            Container(
              child: Text(
                "Name: " + document["displayName"],
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                "Age: " + document["age"],
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                "Location: " + document["location"],
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                "Blood Group: " + document["bloodType"],
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                "Contact number: " + document["ph_num"],
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                "E-mail: " + document["email"],
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
          ],
        );
      }
      return Text("");
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, "/"),
        ),
        title: Text('Blood Donation'),
      ),
      body: Container(
        child: StreamBuilder(
          stream: firestore.collection("Users").snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                return ListView(
                  children: makeListWidget(snapshot),
                );
            }
          },
        ),
      ),
    );
  }
}
