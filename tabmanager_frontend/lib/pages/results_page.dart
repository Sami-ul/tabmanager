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
        FutureBuilder,
        Icon,
        IconButton,
        Icons,
        Key,
        LinearGradient,
        MaterialPageRoute,
        MediaQuery,
        Navigator,
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
import 'package:tabmanager/pages/search_page.dart';
import 'package:tabmanager/widgets/category_item.dart' show CategoryItem;
import 'package:tabmanager/widgets/popup.dart' show ErrorPopup, NewLinkPopup;

class SearchResults extends StatefulWidget {
  const SearchResults(this.query, {Key? key}) : super(key: key);

  final String query;

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  Map<String, CategoryItem> movableItems = {};
  int index = 0;

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
            movableItems[i] = CategoryItem(separated[i], i);
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
        title: Center(
          child: SelectableText(
            widget.query,
            style: const TextStyle(color: Colors.white, fontSize: 34),
          ),
        ),
      ),
      body: FutureBuilder(
        builder: futureBuildResults,
        future: APIRequests.searchLinks(widget.query),
      ),
    );
  }
}
