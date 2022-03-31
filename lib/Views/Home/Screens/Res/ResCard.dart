import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Rescard extends StatefulWidget {
  final List queried;
  const Rescard({Key? key, required this.queried}) : super(key: key);

  @override
  State<Rescard> createState() => _RescardState();
}

class _RescardState extends State<Rescard> {
  @override
  Widget build(BuildContext context) {
    var t = widget.queried;
    return GridView.count(
      crossAxisCount: 1,
      mainAxisSpacing: 2,
      children: List.generate(
        t.length,
        (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: GridTile(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${t[index]['title']}",
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${t[index]['snippet']}",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              footer: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () => _launchInBrowser(t[index]['link']),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.remove_red_eye_rounded),
                      Text("View more"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }
}
