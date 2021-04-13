import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_router_example/api/packages.dart';
import 'package:test/test.dart';

void main() {
  HttpServer server;
  String baseUrl;
  Router app;

  setUp(() async {
    app = Router();
    app.mount('/api/', Packages().router);
    server = await serve(app, 'localhost', 8083);
    baseUrl = 'http://${server.address.host}:${server.port}';
  });

  tearDown(() async {
    await server.close(force: true);
    server = null;
    baseUrl = null;
  });

  test('Should Return Single Pacakge if Method is GET', () async {
    final client = HttpClient();
    final url = Uri.parse('$baseUrl/api/packages/provider');
    final request = await client.getUrl(url);
    final response = await request.close();

    expect(response.statusCode, HttpStatus.ok);
    final contentType = response.headers.contentType;
    expect(contentType.toString(), ContentType.json.toString());

    final rawJson = await readResponse(response);
    Map<String, dynamic> song = jsonDecode(rawJson);
    expect(song['name'], isNotNull);
    expect(song['version'].length, greaterThan(0));
    expect(song['archive_url'], isNotNull);
  });

  test('Return Method Forbidden if Header does not contain Admin', () async {
    final client = HttpClient();
    final url = Uri.parse('$baseUrl/api/packages/provider');
    final request = await client.deleteUrl(url);
    final response = await request.close();
    expect(response.statusCode, HttpStatus.forbidden);
  });

  test('Should Return Method Not Found Method is POST', () async {
    final client = HttpClient();
    final url = Uri.parse('$baseUrl/api/packages/provider');
    final request = await client.postUrl(url);
    final response = await request.close();
    expect(response.statusCode, HttpStatus.notFound);
  });

  test('Should Return Method Forbidden if body is empty', () async {
    final client = HttpClient();
    final url = Uri.parse('$baseUrl/api/packages/');
    final request = await client.postUrl(url);
    final response = await request.close();
    expect(response.statusCode, HttpStatus.forbidden);
  });
}

Future<String> readResponse(HttpClientResponse response) async {
  final contents = StringBuffer();
  await for (var data in response.transform(utf8.decoder)) {
    contents.write(data);
  }
  return contents.toString();
}
