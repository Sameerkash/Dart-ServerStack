import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;

/// QuerySelectors to get a refrence to the elements by Id.
DivElement pacakges = querySelector('#packages');
DivElement versions = querySelector('#versions');
ParagraphElement title = querySelector('#title');

void main() {
  fetchPackages();
}

/// Fecth pacakges from API endpoint
Future<void> fetchPackages() async {
  final result = await http.get(Uri.http('localhost:8083', 'api/packages/'));
  requestComplete(result);
}

/// Call method based on statusCode of the request
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

/// Modify the Element and append data as children obtained from endpoint
void listPackages(String json) {
  for (final p in jsonDecode(json)) {
    pacakges.children.add(DivElement()
      ..text = p['name']
      ..className = 'package'
      ..children.add(ParagraphElement()..text = p['version']));
  }
}
