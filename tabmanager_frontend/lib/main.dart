import 'dart:convert';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:tabmanager/JSON_Deserialization/link.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';

void main() {
  runApp(const HomeView());
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> movableItems = [];
  int index = 0;
  Future<List<Link>> getLinks() async {
    String url = "http://localhost:3000/links";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var linksList = (json.decode(response.body) as List)
          .map((e) => Link.fromJson(e))
          .toList(); // deserialize
      return linksList;
    } else {
      throw Exception("Failed to load");
    }
  }

  Map<String, List<Link>> separateToCategories(List<Link> links) {
    // TODO do this in db later
    Map<String, List<Link>> result = {};
    print(links);
    for (Link i in links) {
      if (result[i.category] != null) {
        result[i.category]!.add(i);
      } else {
        result[i.category!] = [];
        result[i.category]!.add(i);
      }
    }
    return result;
  }

  Widget futureBuildResults(
      BuildContext context, AsyncSnapshot<List<Link>> snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data!.isNotEmpty) {
        if (snapshot.data != null) {
          Map<String, List<Link>> separated =
              separateToCategories(snapshot.data!);
          for (String i in separated.keys) {
            movableItems.add(MoveableStackItem(separated[i], i));
          }
        }
        return Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                  decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Colors.blue, Colors.white]),
              )),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              backgroundColor: Colors.white,
              shadowColor: Colors.white,
              title: Row(children: const [
                SizedBox(width: 20),
                Text(
                  "Tab Manager",
                  style: TextStyle(color: Colors.black),
                )
              ]),
            ),
            body: Stack(
              children: movableItems,
            ));
      } else {
        return const Text("No news found for this country");
      }
    } else if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    } else {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder(
      builder: futureBuildResults,
      future: getLinks(),
    ));
  }
}

class MoveableStackItem extends StatefulWidget {
  MoveableStackItem(List<Link>? this.content, this.category, {Key? key})
      : super(key: key);
  List<Link>? content;
  String category;
  @override
  State<StatefulWidget> createState() {
    return _MoveableStackItemState(content, category);
  }
}

class _MoveableStackItemState extends State<MoveableStackItem> {
  _MoveableStackItemState(List<Link>? this.content, this.category);
  List<Link>? content;
  String category;

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double xPosition = random.nextDouble() * width;
    double yPosition = random.nextDouble() * height;
    return Positioned(
      top: yPosition,
      left: xPosition,
      child: GestureDetector(
          onPanUpdate: (tapInfo) {
            setState(() {
              xPosition += tapInfo.delta.dx;
              yPosition += tapInfo.delta.dy;
            });
          },
          child: Column(children: [
            Center(
                child: Text(
              category,
              style: const TextStyle(fontSize: 30),
            )),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(25),
              ),
              width: 300,
              height: 200,
              child: ListView.builder(
                  itemCount: content!.length,
                  itemBuilder: (context, i) {
                    return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25))),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade200,
                                  Colors.blue.shade100,
                                  Colors.blue.shade300,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ListTile(title: Text("${content![i].link}")),
                                ElevatedButton(
                                    onPressed: () {
                                      _launchURL("${content![i].link}");
                                    },
                                    child: Text("Open"),
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(EdgeInsets.all(8)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        25.0)))))
                              ],
                            )));
                  }),
            ),
          ])),
    );
  }
}
