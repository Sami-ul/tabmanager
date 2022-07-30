import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tabmanager/JSON_Deserialization/link.dart';
import 'package:http/http.dart' as http;
import 'package:tabmanager/widgets/button_style.dart';

class NewLinkPopup extends StatelessWidget {
  NewLinkPopup({
    Key? key,
  }) : super(key: key);

  void addLink(Link link) async {
    String url = "http://localhost:3000/links";
    var response = await http.post(Uri.parse(url), body: link.toJson());
  }

  @override
  Widget build(BuildContext context) {
    late TextEditingController linkController = TextEditingController();
    late TextEditingController categoryController = TextEditingController();
    late TextEditingController titleController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return BackdropFilter(
      // Blurs the background
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Container(
        color: Colors.black.withOpacity(0.1),
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              // Rounded corners
              borderRadius: const BorderRadius.all(const Radius.circular(25))),
          title: Center(
            child: Form(
              key: formKey,
              child: SafeArea(
                minimum: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      autofocus: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter a title";
                        }
                        return null;
                      },
                      controller: titleController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Title"),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: linkController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter a link";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Link"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter a category (case sensitive)";
                        }
                        return null;
                      },
                      controller: categoryController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Category"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: buttonStyle,
                            onPressed: () async {
                              addLink(Link(
                                title: titleController.text,
                                category: categoryController.text,
                                link: linkController.text,
                              ));
                              Navigator.pop(context); // closes popup
                              const snackBar = SnackBar(
                                backgroundColor:
                                    Color.fromARGB(255, 144, 99, 248),
                                content: Text('Added'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: const Text("Add")),
                        SizedBox(height: 25),
                        ElevatedButton(
                          style: buttonStyle, // Using the style we made
                          onPressed: () {
                            Navigator.pop(
                                context); // Allows the user to close the popup
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ), // What the text will be
        ),
      ),
    );
  }
}

class NewLinkPopupCategory extends StatelessWidget {
  NewLinkPopupCategory(
    this.category, {
    Key? key,
  }) : super(key: key);

  String category;

  void addLink(Link link) async {
    String url = "http://localhost:3000/links";
    var response = await http.post(Uri.parse(url), body: link.toJson());
  }

  @override
  Widget build(BuildContext context) {
    late TextEditingController linkController = TextEditingController();
    late TextEditingController categoryController = TextEditingController();
    late TextEditingController titleController = TextEditingController();
    categoryController.text = category;
    final formKey = GlobalKey<FormState>();
    return BackdropFilter(
      // Blurs the background
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Container(
        color: Colors.black.withOpacity(0.1),
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              // Rounded corners
              borderRadius: const BorderRadius.all(const Radius.circular(25))),
          title: Center(
              child: Form(
                  key: formKey,
                  child: SafeArea(
                      minimum: const EdgeInsets.all(20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              autofocus: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter a title";
                                }
                                return null;
                              },
                              controller: titleController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Title"),
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              controller: linkController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter a link";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Link"),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter a category (case sensitive)";
                                }
                                return null;
                              },
                              controller: categoryController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Category"),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    style: buttonStyle,
                                    onPressed: () async {
                                      addLink(Link(
                                        title: titleController.text,
                                        category: categoryController.text,
                                        link: linkController.text,
                                      ));
                                      Navigator.pop(context); // closes popup
                                      const snackBar = SnackBar(
                                        backgroundColor:
                                            Color.fromARGB(255, 144, 99, 248),
                                        content: Text('Added'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    child: const Text("Add")),
                                SizedBox(height: 25),
                                ElevatedButton(
                                  style: buttonStyle, // Using the style we made
                                  onPressed: () {
                                    Navigator.pop(
                                        context); // Allows the user to close the popup
                                  },
                                  child: const Text(
                                      'Close'), // Text inside the button
                                ),
                              ],
                            ),
                          ])))), // What the text will be
        ),
      ),
    );
  }
}
