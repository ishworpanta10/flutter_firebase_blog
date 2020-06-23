import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';

class FirebaseHelper {
  final _firestore = Firestore.instance;
  final _storageRef = FirebaseStorage.instance;

  // Adding data to firebase db collection

  Future<void> uploadData(blogData) async {
    _firestore.collection('blog').add(blogData).catchError((e) {
      print(e);
    });
  }

  // Uploading image to firebase Storage

  Future<String> uploadImg(File file) async {
    //making folder and image_name.jpg in firebase storage
    final _storageLoc = _storageRef
        .ref()
        .child('BlogImages')
        .child('${randomAlphaNumeric(9)}.jpg');
    //storing the image to firebase storage
    final StorageUploadTask upload = _storageLoc.putFile(file);
    //get image downloadable url
    var downloadUrl = await (await upload.onComplete).ref.getDownloadURL();
    print("Download Url : $downloadUrl");
    return downloadUrl;
  }

  //get data from firebase

  getData() async {
    return await _firestore.collection('blog').getDocuments();
  }
}
