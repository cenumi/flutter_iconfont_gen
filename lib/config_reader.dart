import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

class Glyphs {
  final String unicode;
  final String name;
  final String fontClass;

  Glyphs(this.unicode, this.name, this.fontClass);

  String get uniCodeName => '0x$unicode';
}

class Config {
  String fileName = 'iconfont.dart';
  String jsonName = 'iconfont.json';
  String outPath = 'gen/';
  String className = 'AssetIcons';
  String fontPath;
  String familyName = 'AssetIcons';
  String package;
}

List<Glyphs> readGlyphsConfig(String fontPath, String jsonName) {
  final file =
      File((fontPath.split('/')..removeLast()).join('/') + '/$jsonName');
  final content = json.decode(file.readAsStringSync());
  final list = content['glyphs'];
  return list
      .map<Glyphs>((e) => Glyphs(e['unicode'], e['name'], e['font_class']))
      .toList();
}

Config readConfig() {
  final obj = Config();
  final file = File('pubspec.yaml');

  final yaml = loadYaml(file.readAsStringSync());
  final fontPath = yaml['flutter']['fonts'];

  final config = yaml['iconfont_gen'];

  if (config != null && config['font_family'] != null) {
    obj.familyName = config['font_family'];
  }

  for (final f in fontPath) {
    if (f['family'] == obj.familyName) {
      obj.fontPath = f['fonts'][0]['asset'];
    }
  }
  if (obj.fontPath == null) {
    throw Exception('未发现字体配置');
  }

  if (config == null) {
    return obj;
  }

  final package = config['package'];
  final fileName = config['file_name'];
  final outPath = config['out_path'];
  final className = config['class_name'];
  final jsonName = config['json_name'];

  if (package != null) {
    obj.package = package;
  }

  if (fileName != null) {
    obj.fileName = fileName;
  }

  if (outPath != null) {
    obj.outPath = outPath;
  }

  if (className != null) {
    obj.className = className;
  }
  if (jsonName != null) {
    obj.jsonName = jsonName;
  }

  return obj;
}
