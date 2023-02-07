import 'package:blog_app/screens/blog_editing_screen.dart';
import 'package:blog_app/screens/sign_in_screen.dart';
import 'package:blog_app/widgets/blog_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/blog.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});
  final _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  Stream<QuerySnapshot> getData() async* {
    yield* FirebaseFirestore.instance
        .collection('blogs')
        .where("uId", isEqualTo: user!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Blogs'),
      ),
      body: Stack(
        children: [
          StreamBuilder(
              stream: getData(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                // if (snapshot.hasData) {
                //   return ListView(
                // children: snapshot.data!.docs.map((document) {
                //   String id = document.id;
                //   final blog = BlogModal(
                //     uId: document['uId'],
                //     title: document['title'],
                //     imageUrl: document['imageUrl'],
                //     uMail: document['uMail'],
                //     description: document['description'],
                //     createdOn:
                //         (document['createdOn'] as Timestamp).toDate(),
                //   );
                //   return GestureDetector(
                //     onTap: () => Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => BlogEditingScreen(
                //             blogModal: blog,
                //             id: id,
                //           ),
                //         )),
                //     child: BlogCard(blogModal: blog),
                //   );
                // }).toList(),
                //   );
                // } else if (snapshot.hasError) {
                //   return Text('Error: ${snapshot.error}');
                // } else {
                // return const Center(
                //     child: Text(
                //   "You've not uploaded any blog",
                //   style: TextStyle(fontSize: 20),
                // ));
                // }
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                } else if (snapshot.hasData) {
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    children: snapshot.data!.docs.map((document) {
                      String id = document.id;
                      final blog = BlogModal(
                        uId: document['uId'],
                        title: document['title'],
                        imageUrl: document['imageUrl'],
                        uMail: document['uMail'],
                        description: document['description'],
                        createdOn:
                            (document['createdOn'] as Timestamp).toDate(),
                      );
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlogEditingScreen(
                                blogModal: blog,
                                id: id,
                              ),
                            )),
                        child: BlogCard(blogModal: blog),
                      );
                    }).toList(),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.greenAccent, elevation: 40),
                onPressed: () {
                  _auth.signOut().then((value) =>
                      Navigator.pushReplacementNamed(
                          context, SignInScreen.routeName));
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
