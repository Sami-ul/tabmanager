// Widget imports
import 'package:flutter/material.dart'
    show
        Alignment,
        BorderRadius,
        BoxDecoration,
        BuildContext,
        Card,
        Center,
        Clip,
        Color,
        Colors,
        Column,
        Container,
        EdgeInsets,
        ElevatedButton,
        FontWeight,
        Icon,
        IconButton,
        Icons,
        Key,
        LinearGradient,
        ListTile,
        ListView,
        MainAxisAlignment,
        Padding,
        Radius,
        RoundedRectangleBorder,
        Row,
        ScaffoldMessenger,
        ScrollController,
        SelectableText,
        SizedBox,
        SnackBar,
        State,
        StatefulWidget,
        Text,
        TextAlign,
        TextOverflow,
        TextStyle,
        Tooltip,
        Widget,
        showDialog;
import 'package:tabmanager/widgets/button_style.dart'
    show buttonStyle, dangerButtonStyle;
import 'package:tabmanager/widgets/popup.dart' show NewLinkPopupCategory;

// Interaction imports
import 'package:url_launcher/url_launcher.dart' show canLaunchUrl, launchUrl;
import 'package:flutter/services.dart' show Clipboard, ClipboardData;

// API Imports
import 'package:tabmanager/api_interaction/api_requests.dart' show APIRequests;
import 'package:tabmanager/api_interaction/link.dart' show Link;

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
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
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
                  child: SelectableText(widget.category,
                      style: const TextStyle(
                        fontSize: 24,
                        overflow: TextOverflow.ellipsis,
                      )),
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
                                  child: SelectableText(
                                    "${widget.content![i].title}",
                                    maxLines: 1,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
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
                                  child: SelectableText(
                                    "${widget.content![i].link}",
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                                      content: SelectableText(
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
                                    await APIRequests.removeLink(
                                        widget.content![i]);
                                    if (widget.content!.length == 1) {
                                      widget.notifyParentFull(widget.category);
                                    } else {
                                      widget.notifyParent();
                                    }
                                    await APIRequests.removeLink(
                                        widget.content![i]);
                                    if (widget.content!.length == 1) {
                                      widget.notifyParentFull(widget.category);
                                    } else {
                                      widget.notifyParent();
                                    }
                                    const snackBar = SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(255, 114, 90, 250),
                                      content: SelectableText(
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
                                  child: const SelectableText("Delete"),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                    onPressed: () {
                                      _launchURL("${widget.content![i].link}");
                                    },
                                    style: buttonStyle,
                                    child: const SelectableText("Open")),
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
                child: const SelectableText("Add")),
          ],
        ),
      ),
    );
  }
}
