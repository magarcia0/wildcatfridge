import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'favorites.dart';
import 'main.dart';
import 'fridge.dart';
import 'brewski.dart';

class Pantry extends StatelessWidget {
  const Pantry({Key? key}) : super(key: key);

  _launchURL() async {
    const url = 'https://www.csuchico.edu/basic-needs/pantry.shtml';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: const Text('Click Image for Link!'),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Brewski()),
                );
              },
            ),
            ListTile(
              title: const Text('WildCat Pantry'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
          child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(
                    left: 20.0, top: 10.0, right: 20.0, bottom: 20.0),
                child: ElevatedButton(
                  onPressed: _launchURL,
                  child: SizedBox(
                    width: 300,
                    height: 200,
                    child: Image.asset('assets/images/location.png'),
                  ),
                )),
            const Text(
              'Joe Picard, Basic Needs Administrator',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Student Services Center, Room 196 '),
            const Text('530-898-4098'),
            const Text('basicneeds@csuchico.edu'),
            const Text(
              'Virtual Hours',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('8 a.m.- 5 p.m.'),
            const Text('Monday-Friday'),
            const Text(
              'Pantry Hours',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('10 a.m. - 4 p.m.'),
            const Text('Monday-Thursday'),
            const Text('10 a.m. - 3 p.m.'),
            const Text('Friday'),
            const Text(
              'Mailing Address',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Chico State Basic Needs Project'),
            const Text('400 W. First St.'),
            const Text('Chico, CA 95929-0105'),
          ],
        ),
      )),
    );
  }
}