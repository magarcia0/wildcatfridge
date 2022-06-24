//This code is adapted from Clayton Jacobs open_brewery_db example code
// available at: 
//  https://github.com/claytonjacobs/open_brewery_db

import 'package:flutter/material.dart';
import 'package:open_brewery_db/open_brewery_db.dart';

class Search extends StatefulWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final queryTextController = TextEditingController();
  late String query;

  @override
  void initState() {
    super.initState();
    query = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Search Breweries',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.all(12.0)),
                TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a City'),
                  controller: queryTextController,
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      setState(() => query = queryTextController.text);
                    },
                    child: const Text('Search'),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder<List<Brewery>>(
            future: OpenBreweryDb.searchBreweries(query: query),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext c, int i) {
                      Brewery b = snapshot.data?[i] as Brewery;
                      return ListTile(
                        title: HighlightQueryMatchesName(b: b, q: query),
                        subtitle: Text('${b.city}, ${b.state}'),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    queryTextController.dispose();
    super.dispose();
  }
}

class HighlightQueryMatchesName extends StatelessWidget {
  const HighlightQueryMatchesName({Key? key, required this.b, required this.q})
      : super(key: key);

  final Brewery b;
  final String q;

  @override
  Widget build(BuildContext context) {
    int? startName = b.name?.indexOf(q);
    if (startName != -1) {
      int length = q.length;
      List parts = [];
      parts = [
        b.name?.substring(0, startName!),
        b.name?.substring(startName!, length + startName),
        b.name?.substring(length + startName!, b.name?.length),
      ];
      return RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(text: parts[0] as String),
            TextSpan(
              text: parts[1] as String,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            TextSpan(text: parts[2] as String),
          ],
        ),
      );
    }
    return Text(b.name as String);
  }
}