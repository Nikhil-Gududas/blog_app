import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../crud.dart';
import '../models/blog.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  // bool isLoading = false;
  // CrudMethods crudMethods = new CrudMethods();
  // CollectionReference _reference =
  //     FirebaseFirestore.instance.collection('blogs');
  // Stream<QuerySnapshot>? blogStream;

  // Widget BlogsList() {
  //   return blogStream != null
  //       ? StreamBuilder(
  //           initialData: {
  //               'title': 'title',
  //               'description': 'description',
  //               'imgUrl': 'imageUrl',
  //               'authorName': 'nikhil',
  //             },
  //           stream: blogStream,
  //           builder: (context, snapshot) {
  //             if (snapshot.hasError) {
  //               return Text(snapshot.error.toString());
  //             }
  //             QuerySnapshot<Object>? querySnapshot =
  //                 snapshot.data as QuerySnapshot<Object>?;
  //             var bdocs = querySnapshot!.docs;
  //             return ListView.builder(
  //                 padding: EdgeInsets.symmetric(horizontal: 16),
  //                 itemCount: bdocs.length,
  //                 shrinkWrap: true,
  //                 itemBuilder: (context, index) {
  //                   var blogs = bdocs[index];
  //                   return BlogsTile(
  //                     title: blogs['title'],
  //                     description: blogs['description'],
  //                     imgUrl: blogs['imageUrl'],
  //                     authorName: 'nikhil',
  //                   );
  //                 });
  //           })
  //       : Center(
  //           child: CircularProgressIndicator(),
  //         );
  // }
  Stream<List<BlogModal>> getBlogs() => FirebaseFirestore.instance
      .collection('blogs')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => BlogModal.fromJson(doc.data())).toList());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(title: Text('Blog App')),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: StreamBuilder(
            stream: getBlogs(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              } else if (snapshot.hasData) {
                final blogs = snapshot.data;
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: blogs!.map(buildBlog).toList(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
        // body: CustomScrollView(
        //   physics: const BouncingScrollPhysics(),
        //   slivers: [
        //     mySliverAppBar(
        //       () async {
        //         await Future.delayed(
        //           const Duration(seconds: 1),
        //           () => print('Load new data!'),
        //         );
        //         // await Server.requestNewData();
        //       },
        //       context,
        //     ),
        //     // SliverList(
        //     //   delegate: SliverChildBuilderDelegate(
        //     //     (BuildContext context, int index) => Blogcard(
        //     //       blog: dummyData[index],
        //     //     ),
        //     //     childCount: dummyData.length,
        //     //   ),
        //     // )
        //     SliverToBoxAdapter(
        //     ),
        //   ],
        // ),
        );
  }

  // mySliverAppBar(
  //     Future<void> Function() onStretchTrigger, BuildContext context) {
  //   return SliverAppBar(
  //     pinned: true,
  //     stretch: true,
  //     onStretchTrigger: onStretchTrigger,
  //     // backgroundColor: Colors.teal[800],
  //     expandedHeight: 200.0,
  //     flexibleSpace: FlexibleSpaceBar(
  //       stretchModes: const [
  //         StretchMode.zoomBackground,
  //         StretchMode.fadeTitle,
  //         StretchMode.blurBackground,
  //       ],
  //       title: Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           const Text(
  //             'Blog App',
  //             style: TextStyle(fontFamily: 'NoeDisplay', fontSize: 24),
  //           ),
  //           IconButton(
  //               onPressed: (() =>
  //                   Navigator.pushNamed(context, NewBlogScreen.routeName)),
  //               icon: const Icon(Icons.add))
  //         ],
  //       ),
  //       background: DecoratedBox(
  //         position: DecorationPosition.foreground,
  //         decoration: const BoxDecoration(
  //           gradient: LinearGradient(
  //             begin: Alignment.bottomCenter,
  //             end: Alignment.center,
  //             colors: <Color>[Colors.black26, Colors.black45],
  //           ),
  //         ),
  //         child: Image.network(
  //           'https://images.unsplash.com/photo-1504805572947-34fad45aed93?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

// class BlogsTile extends StatelessWidget {
//   String imgUrl, title, description, authorName;
//   BlogsTile(
//       {required this.imgUrl,
//       required this.title,
//       required this.description,
//       required this.authorName});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16),
//       height: 150,
//       child: Stack(
//         children: <Widget>[
//           ClipRRect(
//             borderRadius: BorderRadius.circular(6),
//             child: CachedNetworkImage(
//               imageUrl: imgUrl,
//               width: MediaQuery.of(context).size.width,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Container(
//             height: 170,
//             decoration: BoxDecoration(
//                 color: Colors.black45.withOpacity(0.3),
//                 borderRadius: BorderRadius.circular(6)),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   title,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 Text(
//                   description,
//                   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
//                 ),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 Text(authorName)
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
