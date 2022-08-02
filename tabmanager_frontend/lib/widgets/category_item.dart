import 'package:flutter/material.dart';
import 'package:tabmanager/json_deserialization/link.dart';
import 'package:tabmanager/widgets/button_style.dart';
import 'package:tabmanager/widgets/popup.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class CategoryItem extends StatefulWidget {
  List<Link>? content;
  String category;
  double xPosition;
  double yPosition;
  final Function notifyParent;
  final Function notifyParentFull;
  ScrollController controller = ScrollController();
  CategoryItem(this.content, this.category, this.xPosition, this.yPosition,
      this.notifyParent, this.notifyParentFull,
      {Key? key})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CategoryItem();
  }
}

class _CategoryItem extends State<CategoryItem> {
  _CategoryItem();
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> removeLink(Link link) async {
    String url = "http://localhost:3000/links/${link.id}";
    await http.delete(Uri.parse(url), body: link.toJson());
    widget.notifyParent();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
        child: Column(
          children: [
            SizedBox(
              width: 300,
              child: Tooltip(
                message: widget.category,
                child: Center(
                  child: Text(
                    widget.category,
                    style: const TextStyle(fontSize: 24),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 350,
              width: 500,
              child: ListView.builder(
                  controller: widget.controller,
                  itemCount: widget.content!.length,
                  itemBuilder: (context, i) {
                    return Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListTile(
                              title: Center(
                                  child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 25,
                                width: 150,
                                child: Tooltip(
                                  message: "${widget.content![i].title}",
                                  child: Text(
                                    "${widget.content![i].title}",
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                                width: 225,
                                child: Tooltip(
                                  message: "${widget.content![i].link}",
                                  child: Text(
                                    "${widget.content![i].link}",
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ))),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  splashRadius: 20,
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(
                                          text: widget.content![i].link),
                                    );
                                    const snackBar = SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(255, 114, 90, 250),
                                      content: Text(
                                        'Copied',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  icon: const Icon(Icons.copy),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await removeLink(widget.content![i]);
                                    if (widget.content!.length == 1) {
                                      widget.notifyParentFull(widget.category);
                                    } else {
                                      widget.notifyParent();
                                    }
                                    await removeLink(widget.content![i]);
                                    if (widget.content!.length == 1) {
                                      widget.notifyParentFull(widget.category);
                                    } else {
                                      widget.notifyParent();
                                    }
                                    const snackBar = SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(255, 114, 90, 250),
                                      content: Text(
                                        'Removed',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  style: dangerButtonStyle,
                                  child: const Text("Delete"),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                    onPressed: () {
                                      _launchURL("${widget.content![i].link}");
                                    },
                                    style: buttonStyle,
                                    child: const Text("Open")),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
                style: buttonStyle,
                onPressed: () async {
                  await showDialog(
                    // Flutter method for showing popups
                    context: context,
                    builder: (context) => NewLinkPopupCategory(widget.category),
                  );
                  widget.notifyParent();
                  widget.notifyParent();
                },
                child: const Text("Add")),
          ],
        ),
      ),
    );
  }
}
