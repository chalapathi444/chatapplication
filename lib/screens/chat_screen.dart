import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Firestore.instance
                .collection('chats/0Ycz9MdLVUoFGqtApexC/messages')
                .snapshots()
                .listen((data) {
              data.documents.forEach((element) {
                print(element['text']);
              });
            });
          },
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('chats/0Ycz9MdLVUoFGqtApexC/messages')
              .snapshots(),
          builder: (ctx, sreamSnapshot) {
            if (sreamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = sreamSnapshot.data.documents;
            return ListView.builder(
              itemCount: sreamSnapshot.data.documents.length,
              itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(8),
                child: Text(documents[index]['text']),
              ),
            );
          },
        ));
  }
}
