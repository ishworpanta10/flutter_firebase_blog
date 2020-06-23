import 'dart:io';

import 'package:firebase_blog/class/firebaseHelper.dart';
import 'package:firebase_blog/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputForm extends StatefulWidget {
  static const String routeName = 'inputform';

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final firebaseHelper = FirebaseHelper();

  final FocusNode titleField = FocusNode();

  final FocusNode descriptionField = FocusNode();

  bool _isloading = false;

  String title, authorName, desc;

  File _selectedImage;

  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    try {
      final pickedFile = await picker.getImage(source: source);
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
        "Image is not selected",
        style: ksnackBarTextStyle,
      )));
      print(e);
    }
  }

  uploadBlog() async {
    if (_selectedImage != null) {
      setState(() {
        _isloading = true;
      });
      //uploading to firebase storage
      String imgurl = await firebaseHelper.uploadImg(_selectedImage);
      //making map to upload in firebase db
      Map<String, String> blogMap = {
        'authorName': authorName,
        'title': title,
        'desc': desc,
        'imgUrl': imgurl,
      };

      firebaseHelper.uploadData(blogMap).then((value) {
        Navigator.pop(context);
      });
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            "Image is required to upload this blog",
            style: ksnackBarTextStyle,
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _saveAndSubmit() {
    final form = formKey.currentState;
    if (form.validate()) {
      print("Form is valid");
      uploadBlog();
    } else {
      print("Form is not valid");
    }
  }

  _showOptionsDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                height: 190,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.blueGrey,
                      child: ListTile(
                        title: Text("Get Picture"),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.photo),
                      title: Text("Select from Gallery"),
                      onTap: () {
                        getImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                    ),
                    Divider(),
                    ListTile(
                        leading: Icon(Icons.camera_alt),
                        title: Text("Take a picture"),
                        onTap: () {
                          getImage(ImageSource.camera);
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                letterSpacing: 1.6,
              ),
            ),
            Text(
              "Blog",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: Icon(Icons.file_upload),
              onPressed: () {
                _saveAndSubmit();
              },
            ),
          )
        ],
        elevation: 0.0,
        titleSpacing: 1.2,
      ),
      body: _isloading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  children: <Widget>[
                    _selectedImage == null
                        ? Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 22.0),
                            height: 170.0,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                _showOptionsDialog();
                              },
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black54,
                                size: 40.0,
                              ),
                            ),
                          )
                        : Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 22.0),
                            height: 170.0,
                            width: width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.file(
                                _selectedImage,
                                width: width,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Form(
                      key: formKey,
                      child: Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22.0),
                              child: TextFormField(
                                textCapitalization:
                                    TextCapitalization.characters,
                                validator: (value) => value.isEmpty
                                    ? "Author name  is required"
                                    : null,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () {
                                  FocusScope.of(context)
                                      .requestFocus(titleField);
                                },
                                onChanged: (value) => authorName = value,
                                decoration: InputDecoration(
                                  hintText: 'Author Name',
                                  contentPadding: const EdgeInsets.all(12.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22.0),
                              child: TextFormField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                validator: (value) {
                                  return value.isEmpty
                                      ? "Title is required"
                                      : null;
                                },
                                textInputAction: TextInputAction.next,
                                focusNode: titleField,
                                onEditingComplete: () {
                                  FocusScope.of(context)
                                      .requestFocus(descriptionField);
                                },
                                onChanged: (value) => title = value,
                                decoration: InputDecoration(
                                  hintText: 'Title Name',
                                  contentPadding: const EdgeInsets.all(12.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0),
                                child: TextFormField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  validator: (value) {
                                    return value.isEmpty
                                        ? "Description is required"
                                        : null;
                                  },
                                  onChanged: (value) => desc = value,
                                  focusNode: descriptionField,
                                  maxLines: 10,
                                  textInputAction: TextInputAction.newline,
                                  decoration: InputDecoration(
                                    hintText: 'Description Here',
                                    contentPadding: const EdgeInsets.all(12.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 100.0),
                      child: RaisedButton(
                        onPressed: () {
                          _saveAndSubmit();
                        },
                        child: Text("Upload"),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
