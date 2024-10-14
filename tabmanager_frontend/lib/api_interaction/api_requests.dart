import 'dart:convert' show json;
import 'package:tabmanager/api_interaction/link.dart' show Link;
import 'package:http/http.dart' as http;

class APIRequests {
  APIRequests();

  static void addLink(Link link) async {
    // take in a link, convert to json and add it to the database
    String url = "http://localhost:3001/links";
    await http.post(Uri.parse(url), body: link.toJson());
  }

  static Future<void> removeLink(Link link) async {
    // create a delete request to the backend using the link id to identify
    String url = "http://localhost:3001/links/${link.id}";
    await http.delete(Uri.parse(url), body: link.toJson());
  }

  static Stream<List<Link>> getLinks() async* {
    // load lists as a stream
    String url = "http://localhost:3001/links";
    while (true) {
      await Future.delayed(const Duration(seconds: 1)); // 1 second delay
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var linksList = (json.decode(response.body) as List)
            .map((e) => Link.fromJson(e))
            .toList(); // deserialize
        yield linksList;
      } else {
        throw Exception("Failed to load");
      }
    }
  }

  static Future<List<Link>> searchLinks(String query) async {
    String url = "http://localhost:3001/search?query=$query";
    while (true) {
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
  }
}
