import 'dart:html';

import 'package:angular2/angular2.dart' show NgStyle, NgModel;
import 'package:angular2/core.dart';
import 'package:np8080/services/textprocessingservice.dart';

@Component(
    selector: 'markdown-preview',
    templateUrl: 'preview_component.html',
    providers: const [TextProcessingService],
    directives: const [NgModel, NgStyle]

)
class PreviewComponent implements OnChanges, OnInit {

  final _nullSanitizer = new NullTreeSanitizer();
  final TextProcessingService _textProcessingService;

  DivElement _htmlDiv;

  PreviewComponent(this._textProcessingService);

  @Input('content')
  String content = "";

  @Input('active')
  bool active;

  @override
  ngOnInit() {
    active = false;
  }

  @override
  ngOnChanges(Map<String, SimpleChange> changes) {
    if (active || changes.containsKey("active"))
      updatePreview();
  }

  void updatePreview() {
    _htmlDiv ??= querySelector('#previewPane');

    _htmlDiv.setInnerHtml(_textProcessingService.convertMarkdownToHtml(content),
        treeSanitizer: _nullSanitizer);
  }

}

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}