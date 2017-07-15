import 'dart:html';

import 'package:angular/angular.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'markdown-preview',
    templateUrl: 'preview_component.html',
    directives: const [NgModel, NgStyle, NgClass])
class PreviewComponent implements OnChanges {
  final NullTreeSanitizer _nullSanitizer = new NullTreeSanitizer();
  final TextProcessingService _textProcessingService;
  final ThemeService _themeService;

  DivElement _htmlDiv;

  PreviewComponent(this._textProcessingService, this._themeService);

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

    _htmlDiv.setInnerHtml(_textProcessingService.convertMarkdownToHtml(content),
        treeSanitizer: _nullSanitizer);
  }

  String getClass() {
    return _themeService.getMainClass();
  }

  String getHeaderClass() {
    return _themeService.getSecondaryClass();
  }
}

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}
