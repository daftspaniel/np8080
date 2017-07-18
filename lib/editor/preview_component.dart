import 'dart:html';

import 'package:angular/angular.dart';
import 'package:np8080/dialog/common/editorcomponentbase.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'markdown-preview',
    templateUrl: 'preview_component.html',
    directives: const [NgModel, NgStyle, NgClass])
class PreviewComponent extends EditorComponentBase implements OnChanges {
  final NullTreeSanitizer _nullSanitizer = new NullTreeSanitizer();

  DivElement _htmlDiv;

  PreviewComponent(
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService);
  @Input('content')
  String content = "";

  @Input('active')
  bool active;

  @override
  ngOnChanges(Map<String, SimpleChange> changes) {
    if (active || changes.containsKey("active")) updatePreview();
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
