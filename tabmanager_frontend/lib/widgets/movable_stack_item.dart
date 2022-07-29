import 'package:flutter/material.dart';
import 'package:tabmanager/JSON_Deserialization/link.dart';
import 'package:tabmanager/widgets/button_style.dart';
import 'package:tabmanager/widgets/popup.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class MoveableStackItem extends StatefulWidget {
  MoveableStackItem(this.content, this.category, this.xPosition, this.yPosition,
      {Key? key})
      : super(key: key);
  List<Link>? content;
  String category;
  double xPosition;
  double yPosition;
  @override
  State<StatefulWidget> createState() {
    return _MoveableStackItemState(content, category, xPosition, yPosition);
  }
}

class _MoveableStackItemState extends State<MoveableStackItem> {
  _MoveableStackItemState(
      this.content, this.category, this.xPosition, this.yPosition);
  List<Link>? content;
  String category;
  double xPosition;
  double yPosition;
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void removeLink(Link link) async {
    String url = "http://localhost:3000/links/${link.id}";
    var response = await http.delete(Uri.parse(url), body: link.toJson());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              clipBehavior: Clip.antiAlias,
              child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 117, 117),
                        Color.fromARGB(255, 144, 99, 248),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(children: [
                    Center(
                        child: Text(
                      category,
                      style: const TextStyle(fontSize: 30),
                    )),
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: ListView.builder(
                          itemCount: content!.length,
                          itemBuilder: (context, i) {
                            return Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ListTile(
                                        title: Center(
                                            child:
                                                Text("${content![i].link}"))),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                _launchURL(
                                                    "${content![i].link}");
                                              },
                                              style: buttonStyle,
                                              child: const Text("Open")),
                                          const SizedBox(width: 8),
                                          ElevatedButton(
                                              onPressed: () {
                                                removeLink(content![i]);
                                                setState(() {});
                                              },
                                              style: dangerButtonStyle,
                                              child: const Text("Delete")),
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                          }),
                    ),
                    ElevatedButton(
                        style: buttonStyle,
                        onPressed: () {
                          showDialog(
                            // Flutter method for showing popups
                            context: context,
                            builder: (context) =>
                                NewLinkPopupCategory(category),
                          );
                          setState(() {});
                        },
                        child: const Text("Add")),
                  ])))),
    );
  }
}
