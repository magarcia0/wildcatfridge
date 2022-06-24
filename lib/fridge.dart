import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_mobile/firebase_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'favorites.dart';
import 'pantry.dart';
import 'main.dart';
import 'brewski.dart';
import 'package:final_mobile/add_fridge.dart';
import 'package:rxdart/rxdart.dart';

class Fridge extends StatefulWidget {
  const Fridge({Key? key}) : super(key: key);

  @override
  State<Fridge> createState() => _MyFridgeState();
}

class _MyFridgeState extends State<Fridge> {
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
          return const MyAApp(title: '');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class MyAApp extends StatefulWidget {
  const MyAApp({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyAAppState createState() => _MyAAppState();
}

class _MyAAppState extends State<MyAApp> {
  bool _initialized = false;

  Future<void> initializeDefault() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseConfig.platformOptions);
    _initialized = true;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget readName() {
    if (!_initialized) {
      initializeDefault();
    }

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Stream documentStream = firestore.collection('test').snapshots();
    Stream expiresStream = firestore.collection('expires').snapshots();

    return StreamBuilder(
      stream: CombineLatestStream.list([
        documentStream,
        expiresStream,
      ]),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (!snapshot.hasData) return const Text('Loading Items...');

        if (kDebugMode) {
          //print('Snapshot Length ${snapshot.data!.docs.length}');
        }
        List<dynamic> list = [];
        List<dynamic> expiresList = [];
        list = snapshot.data[0].docs.map((doc) => doc.data()).toList();
        expiresList = snapshot.data[1].docs.map((doc) => doc.data()).toList();

        return Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Expanded(
              child: SizedBox(
                  height: 392.0,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 50,
                        child: Center(
                            child: Text('${list[index]['name']}' +
                                '       EXPIRE:  ' +
                                '${expiresList[index]['expires']}')),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ))),
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
                image: AssetImage('assets/images/myfridgebg.png'),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Fridge'),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage(
                                title: 'WildCat Fridge+',
                              )),
                    );
                  },
                ),
                ListTile(
                  title: const Text('My Fridge'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('My Favorites'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Favorites(
                                title: 'My Favorites',
                              )),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Find Brew'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Brewski()),
                    );
                  },
                ),
                ListTile(
                  title: const Text('WildCat Pantry'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Pantry()),
                    );
                  },
                ),
              ],
            ),
          ),
          body: Center(
            child: Column(children: [
              Text(
                'My Fridge',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 400,
                width: 280,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      readName(),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddFridge()),
                  );
                },
                child: const Text('Add to Fridge'),
              ),
            ]),
          ),
        ));
  }
}