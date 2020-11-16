import 'dart:io';
import 'package:iconfont_gen/config_reader.dart';

void buildFile(Config config, String content) {
  final d = Directory(config.outPath)..createSync(recursive: true);
  final file = File('${d.path}/${config.fileName}');
  file.writeAsStringSync(content);
}

String buildCode(
    String className, String familyName, String package, List<Glyphs> list) {
  final indent = '  ';
  final buffer = StringBuffer("import 'package:flutter/widgets.dart';");
  buffer
    ..writeln()
    ..writeln()
    ..writeln('class $className {')
    ..write(indent)
    ..writeln('$className._();')
    ..writeln()
    ..write(indent)
    ..writeln('static const String _family = familyName;')
    ..writeln()
    ..writeln('static const String _package = $package;')
    ..writeln();

  for (final g in list) {
    buffer
      ..write(indent)
      ..writeln(
          'static const IconData ${g.fontClass} = IconData(${g.uniCodeName},fontFamily: _family,fontPackage: _package);');
  }

  buffer.writeln('}');
  return buffer.toString();
}
