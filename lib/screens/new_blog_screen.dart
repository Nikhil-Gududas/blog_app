import 'dart:io';

import 'package:blog_app/constants.dart';
import 'package:blog_app/crud.dart';
import 'package:blog_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class NewBlogScreen extends StatefulWidget {
  NewBlogScreen({super.key});
  static const routeName = 'new-blog-screen';

  @override
  State<NewBlogScreen> createState() => _NewBlogScreenState();
}

class _NewBlogScreenState extends State<NewBlogScreen> {
  CrudMethods crudMethods = CrudMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final postRef = FirebaseDatabase.instance.reference().child('Posts');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? image;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  bool showSpinner = false;

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (picker != null) {
        image = File(pickedFile!.path);
      } else {
        print('no file selected');
      }
    });
  }

  Future getCameraGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (picker != null) {
        image = File(pickedFile!.path);
      } else {
        print('no file selected');
      }
    });
  }

  void dialog(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Container(
          height: 120,
          child: Column(children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Camera'),
              onTap: () {
                getCameraGallery();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                getImageGallery();
                Navigator.pop(context);
              },
            ),
          ]),
        ),
      ),
    );
  }

  uploadBlog() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        showSpinner = true;
      });
      try {
        int date = DateTime.now().microsecondsSinceEpoch;
        final user = _auth.currentUser;
        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref('/blogapp$date');
        UploadTask uploadTask = ref.putFile(image!.absolute);
        await Future.value(uploadTask);
        var newUrl = await ref.getDownloadURL();
        Map<String, String> blogMap = {
          "imageUrl": newUrl,
          "title": _titleController.text,
          "description": _descriptionController.text,
          'uMail': user!.email.toString(),
          'uId': user.uid.toString(),
        };
        crudMethods.addData(blogMap).then((value) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        });
      } catch (e) {
        print("ERRORRRRRRRRRRRRRRRRRR$e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('New Blog'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    dialog(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    height: _height * 0.2,
                    width: _width,
                    child: image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              image!.absolute,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade900),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text('Title'),
                          ),
                          controller: _titleController,
                          keyboardType: TextInputType.text,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'title can\'t be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text('Description'),
                          ),
                          controller: _descriptionController,
                          minLines: 1,
                          maxLines: 10,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'description can\'t be empty';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: uploadBlog,
                      child: const Text(
                        'Add Post',
                        style: TextStyle(fontSize: 16),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
