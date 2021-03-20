import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart' as shelf;
import 'package:logging/logging.dart';
import 'package:shelf_example/handlers/response.dart';
import 'package:shelf_example/util/helpers.dart';

// final _logger = Logger("handlers");

final renderTemplate = RenderTamplate.instance;

/// Handles the request for /
Future<shelf.Response> indexHandler(shelf.Request request) async {
  final data = await loadJsonFile();
  final res = renderTemplate.renderTemaplate('home', data);
  return htmlResponse(res);
}
