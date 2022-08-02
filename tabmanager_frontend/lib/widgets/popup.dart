// Widget imports
import 'package:flutter/material.dart'
    show
        AlertDialog,
        BackdropFilter,
        BorderRadius,
        BuildContext,
        Center,
        Color,
        Colors,
        Column,
        Container,
        EdgeInsets,
        ElevatedButton,
        Form,
        FormState,
        GlobalKey,
        InputDecoration,
        Key,
        MainAxisAlignment,
        Navigator,
        OutlineInputBorder,
        Radius,
        RoundedRectangleBorder,
        SafeArea,
        ScaffoldMessenger,
        SelectableText,
        SizedBox,
        SnackBar,
        StatelessWidget,
        Text,
        TextAlign,
        TextEditingController,
        TextFormField,
        TextStyle,
        Widget;
import 'package:tabmanager/widgets/button_style.dart' show buttonStyle;
import 'dart:ui' show Color, ImageFilter, Radius, TextAlign;

// API imports
import 'package:tabmanager/api_interaction/link.dart' show Link;
import 'package:tabmanager/api_interaction/api_requests.dart' show APIRequests;

class NewLinkPopup extends StatelessWidget {
  const NewLinkPopup({
    Key? key,
  }) : super(key: key);

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
              borderRadius: BorderRadius.all(Radius.circular(25))),
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
                            APIRequests.addLink(Link(
                              title: titleController.text,
                              category: categoryController.text,
                              link: linkController.text,
                            ));
                            Navigator.pop(context); // closes popup
                            const snackBar = SnackBar(
                              backgroundColor:
                                  Color.fromARGB(255, 114, 90, 250),
                              content: SelectableText(
                                'Added',
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
                          child: const SelectableText("Add"),
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          style: buttonStyle, // Using the style we made
                          onPressed: () {
                            Navigator.pop(
                                context); // Allows the user to close the popup
                          },
                          child: const SelectableText('Close'),
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
  const NewLinkPopupCategory(
    this.category, {
    Key? key,
  }) : super(key: key);

  final String category;

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
              borderRadius: BorderRadius.all(Radius.circular(25))),
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
                              APIRequests.addLink(
                                Link(
                                  title: titleController.text,
                                  category: categoryController.text,
                                  link: linkController.text,
                                ),
                              );
                              Navigator.pop(context); // closes popup
                              const snackBar = SnackBar(
                                backgroundColor:
                                    Color.fromARGB(255, 114, 90, 250),
                                content: SelectableText(
                                  'Added',
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
                            child: const SelectableText("Add")),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          style: buttonStyle, // Using the style we made
                          onPressed: () {
                            Navigator.pop(
                                context); // Allows the user to close the popup
                          },
                          child: const SelectableText(
                              'Close'), // Text inside the button
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ErrorPopup extends StatelessWidget {
  const ErrorPopup(
    this.message, {
    Key? key,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BackdropFilter(
      // Blurs the background
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Container(
        color: Colors.black.withOpacity(0.1),
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              // Rounded corners
              borderRadius: BorderRadius.all(Radius.circular(25))),
          title: Center(
            child: SelectableText(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          actions: [
            ElevatedButton(
              style: buttonStyle, // Using the style we made
              onPressed: () {
                Navigator.pop(context); // Allows the user to close the popup
              },
              child: const SelectableText('Close'), // Text inside the button
            ),
          ],
        ),
      ),
    );
  }
}
