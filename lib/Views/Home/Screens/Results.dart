import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ilearn/Global/constants.dart';
import 'package:ilearn/Views/Home/Screens/Res/ResCard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Results extends StatefulWidget {
  final String query;
  const Results({Key? key, required this.query}) : super(key: key);

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  String txt = '';
  // initialize WebScraper by passing base url of website

  Future dataProccessed() async {
    var url =
        "https://serpapi.com/search.json?q=${widget.query}&location=Austin%2C+Texas%2C+United+States&hl=en&gl=us&google_domain=google.com&api_key=1459fd03facefa49b5a3b5d6a58ab84806527e65514a66c75e12d7cf0ddf8158";

    var result = await http.get(
      Uri.parse(url),
    );
    if (kDebugMode) {
      print(result.body);
    }
    return result.statusCode == 200
        ? jsonDecode(utf8.decode(result.bodyBytes)) as Map
        : "Nothing yet";
  }

  @override
  void initState() {
    super.initState();
    // dataProccessed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Processed Results'),
      ),
      body: FutureBuilder(
          future: dataProccessed(),
          builder: ((context, snapshot) {
            var match = snapshot.data as Map;
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Rescard(queried: match['organic_results']);
          })),
    );
  }
}
