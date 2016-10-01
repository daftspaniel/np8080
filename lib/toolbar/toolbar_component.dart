import 'dart:html';

import 'package:angular2/core.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/textprocessingservice.dart';

@Component(
    selector: 'editor-toolbar',
    templateUrl: 'toolbar_component.html',
    directives: const [ToolbarComponent],
    providers: const [TextProcessingService])
class ToolbarComponent {

  final TextProcessingService _textProcessingService;

  ToolbarComponent(this._textProcessingService);

  @Input()
  TextDocument note;

  @Input()
  bool showDialog;

  @Output()
  EventEmitter<showDialog> showDialogChange = new EventEmitter<showDialog>();

  void aboutHandler() {
    showDialog = true;
    showDialogChange.emit(showDialog);
  }

  void trimHandler() {
    note.text = _textProcessingService.trimText(note.text);
    note.save();
  }

  void githubHandler() {
    window.location.href = "https://github.com/daftspaniel/np8080";
  }

  void downloadHandler() {
    String text = note.text;
    AnchorElement tl = document.createElement('a');
    tl
      ..attributes['href'] = 'data:text/plain;charset=utf-8,' +
          Uri.encodeComponent(text)
      ..attributes['download'] = "np8080.txt"
      ..click();
  }
}