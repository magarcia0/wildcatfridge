import 'package:final_mobile/add_fridge.dart';
import 'package:final_mobile/helper_favorites.dart';
import 'package:flutter/material.dart';
import 'favorites.dart';
import 'pantry.dart';
import 'fridge.dart';
import 'brewski.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WildCat Fridge+',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'WildCat Fridge+',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/mainbg.png'), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(widget.title),
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
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('My Fridge'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Fridge()),
                  );
                },
              ),
              ListTile(
                title: const Text('My Favorites'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Favorites(
                              title: '',
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: 260,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200.0),
                    //child: Image.asset('assets/images/fridge.png'),
                    child: Image.asset('assets/images/beers2.png'),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0)),
              SizedBox(
                height: 40,
                width: 200,
                child: FloatingActionButton(
                  shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  child: const Text('Add to Fridge'),
                  backgroundColor: const Color.fromARGB(255, 33, 117, 243),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddFridge()),
                    );
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              SizedBox(
                height: 40,
                width: 200,
                child: FloatingActionButton(
                  shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  child: const Text('Find Brewski'),
                  backgroundColor: const Color.fromARGB(255, 33, 117, 243),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Brewski()),
                    );
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              SizedBox(
                height: 40,
                width: 200,
                child: FloatingActionButton(
                  shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  child: const Text('Add Favorite'),
                  backgroundColor: const Color.fromARGB(255, 33, 117, 243),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddScreen(
                                title: 'Add Favorite',
                              )),
                    );
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0)),
            ],
          ),
        ),
      ),
    );
  }
}
