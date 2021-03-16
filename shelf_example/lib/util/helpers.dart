import 'dart:convert';
import 'dart:io';
import 'package:mustache_template/mustache.dart' as mustache;
import 'package:path/path.dart' as path;

class RenderTamplate {
  RenderTamplate._() {
    init();
  }

  static final _instance = RenderTamplate._();

  static RenderTamplate get instance => _instance;

  final viewsPath = 'lib/web/views';
  final current = Directory.current;

  final Map<String, mustache.Template> templates =
      <String, mustache.Template>{};

  void init() {
    _loadTemplates(viewsPath);
  }

  void _loadTemplates(String temPlatepath) {
    final dir = path.join(current.path, viewsPath);

    // print(dir);
    Directory(dir)
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.mustache'))
        .forEach((file) {
      final relativePath = path.relative(file.path, from: temPlatepath);
      final name = path.withoutExtension(relativePath);
      templates[name] = mustache.Template(file.readAsStringSync());
    });
  }

  String renderTemaplate(String name, Map<String, Object> values) {
    final parsedTemaplate = templates[name];
    try {
      print(templates);
      return parsedTemaplate.renderString(values);
    } on mustache.TemplateException catch (e, st) {
      print(e);
      print(st);
    }
  }
}

Future<Map<String, dynamic>> loadJsonFile() async {
  final jsonData = await File('static/videos.json')
      .readAsString()
      .then((fileContents) => json.decode(fileContents));

  return jsonData;
}
