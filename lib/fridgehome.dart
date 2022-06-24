import 'package:flutter/material.dart';
import 'favorites.dart';
import 'pantry.dart';
import 'main.dart';
import 'brewski.dart';


class Fridge extends StatelessWidget {
  const Fridge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  MaterialPageRoute(builder: (context) => const Favorites(title: '',)),
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
            width: 240,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: const [Text('Beer')],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Add to Fridge'),
          ),
        ]),
      ),
    );
  }
}

