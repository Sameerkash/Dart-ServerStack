import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_router_example/film_api.dart';
import 'package:shelf_router_example/packages.dart';

void main(List<String> arguments) async {
  final app = Router();

  app.mount('/api/', Packages().router);

  app.get('/<name|.*>', (Request request, String name) {
    final param = name.isNotEmpty ? name : 'World';
    return Response.ok('Hello $param!');
  });

  await io.serve(app, 'localhost', 8083);
}
