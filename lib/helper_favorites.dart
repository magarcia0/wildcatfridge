//This code adapts from Dr. Dixons S22 example code
//available at:
//  https://github.com/CSUChico-CSCI567/CSCI567_S22_Examples
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'firebase_config.dart';
import 'dart:io';

class AddScreenState extends State<AddScreen> {
  File? _image;
  bool _initialized = false;
  FirebaseApp? firebaseApp;

  Future<void> initializeFlutterFire() async {
    try {
      firebaseApp = await Firebase.initializeApp(
          options: DefaultFirebaseConfig.platformOptions);
      _initialized = true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  void _upload() async {
    if (!_initialized) {
      await initializeFlutterFire();
    }
    if (_image != null) {
      var uuid = const Uuid();

      final String uid = uuid.v4();
      final String downloadURL = await _uploadFile(uid);
      await _addItem(downloadURL);
    }
  }

  Future getImage() async {
    if (!_initialized) {
      await initializeFlutterFire();
    }
    final ImagePicker _picker = ImagePicker();

    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
    setState(() {});
    setState(() {});
  }

  Future<String> _uploadFile(filename) async {
    if (!_initialized) {
      await initializeFlutterFire();
    }
    final Reference ref = FirebaseStorage.instance.ref().child('$filename.jpg');
    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg', contentLanguage: 'en');
    final UploadTask uploadTask = ref.putFile(
      _image!,
      metadata,
    );

    final downloadURL = await (await uploadTask).ref.getDownloadURL();
    return downloadURL.toString();
  }

  Future<void> _addItem(String downloadURL) async {
    if (!_initialized) {
      await initializeFlutterFire();
    }
    await FirebaseFirestore.instance.collection('photos').add(<String, dynamic>{
      'downloadURL': downloadURL,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: _image == null
                  ? const Text('No preview available.')
                  : Image.file(_image!, width: 250),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
            ),
            ElevatedButton(
              onPressed: () {
                _upload();
/*                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const Favorites(title: 'My Favorites')));
              */
              },
              child: const Text('Save', style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 33, 117, 243),
              ),
            )
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
        backgroundColor: const Color.fromARGB(255, 33, 117, 243),
      ),
    );
  }
}

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  AddScreenState createState() => AddScreenState();
}
