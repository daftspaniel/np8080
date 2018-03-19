import 'dart:html';

import 'package:angular/angular.dart';
import 'package:np8080/src/dialog/common/editorcomponentbase.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'text-status',
    templateUrl: 'statuspanel.html',
    directives: const [NgIf, NgClass],
    pipes: const [UpperCasePipe, DatePipe])
class StatusPanel extends EditorComponentBase {
  StatusPanel(
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService);

  @Input('text')
  String text;

  @Input('modified')
  DateTime modified;

  String get length => text.length.toString();

  String get wordCount => textProcessingService.getWordCount(text).toString();

  String get lineCount => textProcessingService.getLineCount(text).toString();

  bool isHttps() {
    return window.location.href.contains('https://') ||
        window.location.href.contains('localhost');
  }
}
