import 'package:shelf/shelf.dart' as shelf;

/// Shelf reponse method to facilitate response sent by handlers
shelf.Response htmlResponse(
  String content, {
  int status = 200,
  Map<String, String> headers,
  bool noReferrer = false,
}) {
  headers ??= <String, String>{};
  headers['content-type'] = 'text/html; charset="utf-8"';
  headers['referrer-policy'] =
      noReferrer ? 'no-referrer' : 'no-referrer-when-downgrade';
  return shelf.Response(status, body: content, headers: headers);
}
