import 'package:shelf/shelf.dart';

/// Middleware to handle CORS and PUB specific headers
Middleware handleHeaders() {
  final corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
    'Access-Control-Allow-Headers': 'Origin, Content-Type',
  };

  /// Pub Hosted Repository specification headers
  final pubRequest = {'Accept': 'application/vnd.pub.v2+json'};

  final pubResponse = {'Content-Type': 'application/vnd.pub.v2+json'};

  return createMiddleware(requestHandler: (Request request) {
    if (request.method.toLowerCase() == 'options') {
      return Response.ok('', headers: corsHeaders..addAll(pubRequest));
    }
    return null;
  }, responseHandler: (Response response) {
    return response.change(headers: corsHeaders..addAll(pubResponse));
  });
}
