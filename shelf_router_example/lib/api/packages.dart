import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_router_example/constants.dart';
import '../util/extensions.dart';

class Packages {
  /// Instance of the json file acting as a database.
  static final File packagesJson = File('packages.json');

  /// intitialize the list of data
  final List data = json.decode(packagesJson.readAsStringSync());

  Router get router {
    final router = Router();

    /// Get Request to confirm api route is available
    router.get('/', (request) {
      return Response.ok(
          'API is alive, get packages to get the list of packages');
    });

    /// Get endpoint to list all packages available
    router.get('/packages/', (Request request) {
      print(request.requestedUri);
      return Response.ok(json.encode(data), headers: headers);
    });

    /// Get endpoint to fetch a particular package
    router.get('/packages/<name>', (request, String name) {
      final package =
          data.firstWhere((p) => p['name'] == name, orElse: () => null);
      return Response.ok(json.encode(package), headers: headers);
    });

    /// Post ednpoint to add a package to the list of packages
    router.post('/packages/', (request) async {
      final payload = await request.readAsString();
      if (payload.isEmpty || payload == null) {
        return Response.forbidden('Pleas enter valid package details');
      }
      data.add(json.decode(payload));
      packagesJson.writeAsStringSync(json.encode(data));
      return Response.ok(json.encode(data), headers: headers);
    });

    /// Delete endpoint to delete a package specified by name, headers must contain admin token
    router.delete('/packages/<name>', (Request request, String name) {
      final isAdmin = request.headers['isAdmin']?.parseBool() ?? false;

      if (isAdmin) {
        data.removeWhere((p) => p['name'] == name);
        packagesJson.writeAsStringSync(json.encode(data));
        return Response.ok(json.encode(data), headers: headers);
      } else {
        return Response.forbidden('Not Authorized');
      }
    });

    return router;
  }
}
