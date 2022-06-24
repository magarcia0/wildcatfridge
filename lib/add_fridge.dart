import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase_config.dart';

// ignore: must_be_immutable
class AddFridge extends StatefulWidget {
  AddFridge({Key? key}) : super(key: key);
  FirebaseApp? firebaseApp;

  @override
  AddFridgeState createState() => AddFridgeState();
}

class AddFridgeState extends State<AddFridge> {
  String _expiresInput = "";
  String _formInput = "";
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

  Future<void> addItem(String name) async {
    if (!_initialized) {
      await initializeFlutterFire();
    }
    await FirebaseFirestore.instance.collection('test').add(<String, dynamic>{
      'name': name,
    });
  }

  Future<void> addExpires(String expires) async {
    if (!_initialized) {
      await initializeFlutterFire();
    }
    await FirebaseFirestore.instance
        .collection('expires')
        .add(<String, dynamic>{
      'expires': expires,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Add to Fridge'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getForm(),
            const Text("Added to Your Fridge:"),
            _formInput == ""
                ? const SizedBox()
                : Text(_formInput + "   " + _expiresInput,
                    style: Theme.of(context).textTheme.headline4),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      setState(() {});
      return true;
    }
    return false;
  }

  String? validate(value) {
    if (value.isEmpty) {
      return 'Field can\'t be empty';
    }
    if (value.contains('@')) {
      return 'Field can\'t contain @';
    }
    return null;
  }

  Form getForm() {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputs() + buildSubmitButtons()));
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        key: const Key("firstname"),
        validator: validate,
        decoration: const InputDecoration(
          icon: Icon(Icons.food_bank_outlined),
          hintText: 'Juice',
          labelText: 'Enter your item: ',
        ),
        onSaved: (String? value) {
          _formInput = value!;
          addItem(_formInput);
        },
      ),
      TextFormField(
        key: const Key("expires"),
        validator: validate,
        decoration: const InputDecoration(
          icon: Icon(Icons.dangerous_outlined),
          hintText: 'X/XX/XX',
          labelText: 'Expiration Date:',
        ),
        onSaved: (String? val) {
          _expiresInput = val!;
          addExpires(_expiresInput);
        },
      ),
    ];
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      const snackBar = SnackBar(
        content: Text('Item Added Successfully'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  List<Widget> buildSubmitButtons() {
    return [
      Center(
        child: ElevatedButton(
          key: const Key("submit"),
          onPressed: validateAndSubmit,
          child: const Text("Submit"),
        ),
      )
    ];
  }
}