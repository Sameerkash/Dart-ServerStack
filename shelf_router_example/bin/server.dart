import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_router_example/api/packages.dart';

void main(List<String> arguments) async {
  /// final router instance
  final app = Router();

  /// api middleware that routes to Packages
  app.mount('/api/', Packages().router);

  /// sample get endpoint
  app.get('/<name|.*>', (Request request, String name) {
    final param = name.isNotEmpty ? name : 'World';
    return Response.ok('Hello $param!');
  });

  /// instance of serveri
  final server = await io.serve(app, 'localhost', 8083);

  print('Serving at http://${server.address.host}:${server.port}');
}
