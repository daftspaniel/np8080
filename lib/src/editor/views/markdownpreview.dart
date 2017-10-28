import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:np8080/src/dialog/common/editorcomponentbase.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'markdown-preview',
    templateUrl: 'markdownpreview.html',
    visibility: Visibility.none,
    directives: const [NgModel, NgStyle, NgClass])
class MarkdownPreview extends EditorComponentBase implements OnChanges {
  final NullTreeSanitizer _nullSanitizer = new NullTreeSanitizer();

  DivElement _htmlDiv;

  MarkdownPreview(
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService) {
    eventBusService.subscribe('ShowMarkdownPreview', () => active = true);
    eventBusService.subscribe('HideMarkdownPreview', () => active = false);
  }

  @Input('content')
  String content = "";

  bool active = false;

  ngOnChanges(Map<String, SimpleChange> changes) {
    updatePreview();
  }

  void updatePreview() {
    _htmlDiv ??= querySelector('#previewPane');

    _htmlDiv.setInnerHtml(textProcessingService.convertMarkdownToHtml(content),
        treeSanitizer: _nullSanitizer);
  }
}

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}
