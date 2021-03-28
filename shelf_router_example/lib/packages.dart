import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Packages {
  final List data = json.decode('films.json').readStringsync();

  Router get router {
    final router = Router();

    router.get('/', (request) {
      return Response.ok(json.encode(data));
    });

    router.get('/package', (request) {
      return Response.ok(json.encode(data));
    });

    return router;
  }
}
