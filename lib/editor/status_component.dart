import 'dart:html';

import 'package:angular/angular.dart';
import 'package:np8080/dialog/common/editorcomponentbase.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'text-status',
    templateUrl: 'status_component.html',
    directives: const [NgIf, NgClass],
    pipes: const [UpperCasePipe, DatePipe])
class StatusComponent extends EditorComponentBase {
  StatusComponent(
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
    return window.location.href.contains('https://');
  }
}
