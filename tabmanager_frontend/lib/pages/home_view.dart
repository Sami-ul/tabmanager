import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../json_deserialization/link.dart';
import '../widgets/category_item.dart';
import '../widgets/popup.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Map<String, CategoryItem> movableItems;
  int index = 0;
  void notifyParent() {
    setState(() {
      build(context);
    });
  }

  @override
  void initState() {
    super.initState();
    movableItems = {};
  }

  void notifyParentFull(String category) {
    setState(() {
      movableItems = {};
    });
  }

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
          double posX = 10, posY = 10;
          double maxX = MediaQuery.of(context).size.width;
          for (String i in separated.keys) {
            if (posX + 310 >= maxX) {
              posX = 10;
              posY += 400;
            }
            movableItems[i] = CategoryItem(
                separated[i], i, posX, posY, notifyParent, notifyParentFull);
            posX += 330;
          }
        }
        return CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 4,
                children: movableItems.values.toList(),
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    } else if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    movableItems = {};
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: <Color>[
                  Color.fromARGB(255, 125, 138, 255),
                  Color.fromARGB(255, 255, 117, 117),
                ],
              ),
            ),
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          title: const Center(
            child: Text(
              "Tab Manager",
              style: TextStyle(color: Colors.white, fontSize: 34),
            ),
          )),
      body: FutureBuilder(
        builder: futureBuildResults,
        future: getLinks(),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: const Color.fromARGB(255, 114, 90, 250),
        overlayColor: Colors.black,
        overlayOpacity: 0.3,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: "Add new link",
            onTap: () async {
              await showDialog(
                // Flutter method for showing popups
                context: context,
                builder: (context) => const NewLinkPopup(),
              );
              setState(() {
                build(context);
              });
            },
          )
        ],
      ),
    );
  }
}
