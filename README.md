A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/`.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

Flutter project only

Usage:

pubspec.yaml
```yaml
# default
iconfont_gen:
  file_name: iconfont.dart
  json_name: iconfont.json
  out_path: gen/
  class_name: AssetIcons
  font_family: AssetIcons


flutter: 
  fonts:
    - family: AssetIcons # same as font_family above
      fonts:
        - asset: xx/xx.ttf
```