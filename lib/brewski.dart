import 'package:flutter/material.dart';
import 'search.dart';
import 'favorites.dart';
import 'pantry.dart';
import 'fridge.dart';
import 'main.dart';

class Brewski extends StatelessWidget {
  const Brewski({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Container(    
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/brew.jpg'), 
          fit: BoxFit.cover)),
    
    
    child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Breweries'),
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
                  MaterialPageRoute(builder: (context) => const Favorites(title: '',)),
                );
              },
            ),
            ListTile(
              title: const Text('Find Brew'),
              onTap: () {
                Navigator.pop(context);
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
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Column(
          children: [
            SizedBox(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Search(),
                    ),
                  );
                },
                child: const Text('Search Breweries'),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
