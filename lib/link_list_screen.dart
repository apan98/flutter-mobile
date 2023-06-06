import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'link.dart';
import 'web_view_screen.dart';

class LinkListScreen extends StatefulWidget {
  @override
  _LinkListScreenState createState() => _LinkListScreenState();
}

class _LinkListScreenState extends State<LinkListScreen> {
  late Future<List<Link>> futureLinks;

  @override
  void initState() {
    super.initState();
    futureLinks = fetchLinks();
  }

  Future<List<Link>> fetchLinks() async {
    Uri uri = Uri.http('10.0.2.2:8080', '/v2/links');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Link.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load links');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Links'),
      ),
      body: FutureBuilder<List<Link>>(
        future: futureLinks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Link> links = snapshot.data!;
            return ListView.builder(
              itemCount: links.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(links[index].url),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewScreen(url: links[index].url),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
