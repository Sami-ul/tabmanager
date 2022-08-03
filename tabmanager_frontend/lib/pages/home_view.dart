import 'package:flutter/material.dart'
    show
        Alignment,
        AnimatedIcons,
        AppBar,
        AsyncSnapshot,
        BorderRadius,
        BuildContext,
        Center,
        CircularProgressIndicator,
        Color,
        Colors,
        Container,
        CustomScrollView,
        EdgeInsets,
        Icon,
        Icons,
        Key,
        LinearGradient,
        MediaQuery,
        Radius,
        RoundedRectangleBorder,
        Scaffold,
        SelectableText,
        ShapeDecoration,
        SliverGrid,
        SliverPadding,
        State,
        StatefulWidget,
        StreamBuilder,
        Text,
        TextStyle,
        Widget,
        showDialog;
import 'package:flutter_speed_dial/flutter_speed_dial.dart'
    show SpeedDial, SpeedDialChild;
import 'package:tabmanager/api_interaction/api_requests.dart' show APIRequests;
import 'package:tabmanager/api_interaction/link.dart' show Link;
import 'package:tabmanager/widgets/category_item.dart' show CategoryItem;
import 'package:tabmanager/widgets/popup.dart' show ErrorPopup, NewLinkPopup;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Map<String, CategoryItem> movableItems = {};
  int index = 0;
  void notifyParent() {}

  void notifyParentFull(String category) {}

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
          for (String i in separated.keys) {
            movableItems[i] =
                CategoryItem(separated[i], i, notifyParent, notifyParentFull);
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
      return ErrorPopup(snapshot.error.toString());
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: SelectableText(
              "Tab Manager",
              style: TextStyle(color: Colors.white, fontSize: 34),
            ),
          )),
      body: StreamBuilder(
        builder: futureBuildResults,
        stream: APIRequests.getLinks(),
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
            },
          )
        ],
      ),
    );
  }
}
