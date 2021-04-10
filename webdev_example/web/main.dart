import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;

UListElement pacakges = querySelector('#packages');
void main() {
  fetchPackages();
}

Future<void> fetchPackages() async {
  final result = await http.get(Uri.http('localhost:8083', 'api/packages/'));
  requestComplete(result);
}

void requestComplete(http.Response response) {
  switch (response.statusCode) {
    case 200:
      listPackages(response.body);
      return;
    default:
      final li = LIElement()
        ..text = 'Request failed, status=${response.statusCode}';
      pacakges.children.add(li);
  }
}

void listPackages(String json) {
  for (final p in jsonDecode(json)) {
    pacakges.children.add(LIElement()..text = p['name']);
  }
}
