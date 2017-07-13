import 'dart:html';

import 'package:angular/angular.dart'
    show UpperCasePipe, DatePipe, NgIf, NgClass;
import 'package:angular/core.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'text-status',
    templateUrl: 'status_component.html',
    directives: const [NgIf, NgClass],
    pipes: const [UpperCasePipe, DatePipe]
)
class StatusComponent {

  final TextProcessingService _textProcessingService;
  final ThemeService _themeService;

  StatusComponent(this._textProcessingService, this._themeService);

  @Input('text')
  String text;

  @Input('modified')
  DateTime modified;

  String get length => text.length.toString();

  String get wordCount => _textProcessingService.getWordCount(text).toString();

  String get lineCount => _textProcessingService.getLineCount(text).toString();

  bool isHttps() {
    return window.location.href.contains('https://');
  }

  String getClass() {
    return _themeService.getMainClass();
  }
}
