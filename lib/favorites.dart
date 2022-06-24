//This code adapts from Dr. Dixons S22 example code
//available at:
//  https://github.com/CSUChico-CSCI567/CSCI567_S22_Examples
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_mobile/helper_favorites.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyFaveState createState() => _MyFaveState();
} //Favorites

class _MyFaveState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (kDebugMode) {
            print(snapshot.error);
          }
          return const Text("Something Went Horribly Wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MyAwesomeApp(title: widget.title);
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

class MyAwesomeApp extends StatefulWidget {
  const MyAwesomeApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyAwesomeAppState createState() => _MyAwesomeAppState();
}

class _MyAwesomeAppState extends State<MyAwesomeApp> {
  late FixedExtentScrollController scrollController;

  @override
  void initState() {
    scrollController = FixedExtentScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Widget photoWidget(AsyncSnapshot<QuerySnapshot> snapshot, index) {
    try {
      return Column(
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(children: <Widget>[
              Image.network(
                snapshot.data!.docs[index]['downloadURL'],
                height: 200,
              ), //const Padding(padding: EdgeInsets.all(50.0)),
              //  const Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 10)),
              const Padding(padding: EdgeInsets.all(20.0)),
              const Text('Your Favorite Product!')
            ]),
          ),
        ],
      );
    } catch (e) {
      return ListTile(title: Text("Error:" + e.toString()));
    }
  }

  Widget getNames() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('photos').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (!snapshot.hasData) return const Text('Loading Photos...');

        if (kDebugMode) {
          print('Snapshot Length ${snapshot.data!.docs.length}');
        }
        return Expanded(
          child: Scrollbar(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return photoWidget(snapshot, index);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/stars.jpg'),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('My Favorites'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                getNames(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddScreen(
                          title: "Add Favorite",
                        )),
              );
            },
            child: const Icon(Icons.add),
            backgroundColor: const Color.fromARGB(255, 33, 117, 243),
          ),
        ));
  }
}
