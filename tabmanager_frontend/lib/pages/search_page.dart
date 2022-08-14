import 'package:flutter/material.dart';
import 'package:tabmanager/pages/results_page.dart';

import '../widgets/button_style.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

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
            "Search",
            style: TextStyle(color: Colors.white, fontSize: 34),
          ),
        ),
      ),
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: searchController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Search"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SearchResults(searchController.text)));
                  },
                  child: const Text("Search"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
