import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_router_example/api/packages.dart';
import 'package:shelf_router_example/util/middleware.dart';

void main(List<String> arguments) async {
  /// router instance
  final app = Router();

  /// api middleware that routes to Packages
  app.mount('/api/', Packages().router);

  /// sample get endpoint
  app.get('/<name|.*>', (shelf.Request request, String name) {
    final param = name.isNotEmpty ? name : 'World';
    return shelf.Response.ok('Hello $param!');
  });

  /// Handler to connect Middlewares
  var handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addMiddleware(handleCors())
      .addHandler(app);

  /// instance of server
  final server = await io.serve(handler, 'localhost', 8083);

  print('Serving at http://${server.address.host}:${server.port}');
}
