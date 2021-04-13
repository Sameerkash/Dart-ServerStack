import 'dart:io';

import 'package:args/args.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_example/handlers/handler.dart';
import 'package:shelf_static/shelf_static.dart';

// For Google Cloud Run, set _hostname to '0.0.0.0'.
const _hostname = 'localhost';

void main(List<String> args) async {
  var parser = ArgParser()..addOption('port', abbr: 'p');
  var result = parser.parse(args);

  // For Google Cloud Run, we respect the PORT environment variable
  var portStr = result['port'] ?? Platform.environment['PORT'] ?? '8000';
  var port = int.tryParse(portStr);

  if (port == null) {
    stdout.writeln('Could not parse port value "$portStr" into a number.');
    // 64: command line usage error
    exitCode = 64;
    return;
  }

  /// static handler to serve css and json files placed in the public directory
  final staticHandler = createStaticHandler('public');

  /// Handler to route requsts according to the url.path
  final cascadeHandler = shelf.Cascade()
      .add((request) async => staticHandler.call(request))
      .add((request) {
    if (request.url.path == '') {
      return indexHandler(request);
    } else {
      return shelf.Response.notFound('Error Not Fund');
    }
  }).add((request) {
    if (request.url.path == 'engage') {
      return engageHandler(request);
    } else {
      return shelf.Response.notFound('Error Not Fund');
    }
  }).add((request) {
    if (request.url.path == 'europe') {
      return europeHandler(request);
    } else {
      return shelf.Response.notFound('Error Not Fund');
    }
  }).handler;

  /// handler to add accomodate Middlewares
  var handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addHandler(cascadeHandler);

  /// instance of server
  var server = await io.serve(handler, _hostname, port);
  print('Serving at http://${server.address.host}:${server.port}');
}
