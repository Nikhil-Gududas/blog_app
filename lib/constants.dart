import 'package:blog_app/themes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'models/blog.dart';

const double defaultPadding = 20;
final brandingWidget = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    SizedBox(
        height: 50,
        width: 50,
        child: Image.asset(
          'assets/images/logo.png',
          color: Colors.white,
        )),
    const SizedBox(
      width: 20,
    ),
    Text(
      "Blog App",
      style: MyThemes.headline1,
    ),
  ],
);

void toastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget buildBlog(BlogModal blog) {
  return GestureDetector(
    // onTap: () => Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const BlogDetailScreen(),
    //     )),
    child: Container(
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.grey.shade800, width: 2),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        radius: 15,
                        child: Text('N'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Nikhil',
                          style: TextStyle(color: Colors.white, fontSize: 14))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    blog.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text('2 Oct . 2 min read',
                      style: TextStyle(
                          color: Colors.blueGrey.shade100, fontSize: 14))
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            height: 80,
            width: 80,
            color: Colors.green,
            child: CachedNetworkImage(imageUrl: blog.imageUrl),
          )
        ],
      ),
    ),
  );
  // return Container(
  //   margin: const EdgeInsets.only(bottom: 12),
  //   decoration: BoxDecoration(
  //     color: Colors.black54,
  //     borderRadius: BorderRadius.circular(10),
  //   ),
  //   width: double.infinity,
  //   child: ClipRRect(
  //     borderRadius: BorderRadius.circular(10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         CachedNetworkImage(
  //           imageUrl: blog.imageUrl,
  //           height: 200,
  //           width: double.infinity,
  //           fit: BoxFit.cover,
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Text(
  //             blog.title.toUpperCase(),
  //             style: TextStyle(
  //                 fontFamily: 'Poppins',
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Text(blog.description),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Text("By:  ${blog.uMail}"),
  //         )
  //       ],
  //     ),
  //   ),
  // );
}
