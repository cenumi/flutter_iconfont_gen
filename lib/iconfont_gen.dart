
import 'code_builder.dart';
import 'config_reader.dart';

void start(){
  final config = readConfig();

  final content = readGlyphsConfig(config.fontPath,config.jsonName);

  final code = buildCode(config.className, config.familyName, content);

  buildFile(config, code);
}
