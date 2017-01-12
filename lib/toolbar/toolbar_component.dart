import 'dart:html';

import 'package:angular2/core.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/editablelabel/editablelabel_component.dart';
import 'package:np8080/services/textprocessingservice.dart';

@Component(
    selector: 'editor-toolbar',
    templateUrl: 'toolbar_component.html',
    directives: const [ToolbarComponent,
    EditableLabelComponent
    ],
    providers: const [TextProcessingService])
class ToolbarComponent {

  final TextProcessingService _textProcessingService;

  ToolbarComponent(this._textProcessingService) {
    display = new List<String>();
    display.add("none");
    display.add("none");
    display.add("none");
    display.add("none");
    display.add("none");
  }

  List<String> display;

  @Input()
  TextDocument note;

  @Input()
  bool showAboutDialog;

  @Input()
  bool showReplaceDialog;

  @Input()
  bool showGenerateDialog;

  @Input()
  bool showPreview;

  @Output()
  EventEmitter<bool> showAboutDialogChange = new EventEmitter<bool>();

  @Output()
  EventEmitter<bool> showReplaceDialogChange = new EventEmitter<bool>();

  @Output()
  EventEmitter<bool> showPreviewChange = new EventEmitter<bool>();

  @Output()
  EventEmitter<bool> showGenerateDialogChange = new EventEmitter<bool>();

  void markdownHandler() {
    showPreview = !showPreview;
    showPreviewChange.emit(showPreview);
  }

  void aboutHandler() {
    showAboutDialog = true;
    showAboutDialogChange.emit(showAboutDialog);
  }

  void clearHandler() {
    if (window.confirm(
        "Are you sure you want to clear the current document?")) {
      note.text = "";
      note.save();
    }
  }

  void trimHandler() {
    note.text = _textProcessingService.trimText(note.text);
    note.save();
  }

  void sortHandler() {
    note.text = _textProcessingService.sort(note.text);
    note.save();
  }

  void reverseHandler() {
    note.text = _textProcessingService.reverse(note.text);
    note.save();
  }

  void replaceHandler() {
    showReplaceDialog = true;
    showReplaceDialogChange.emit(showReplaceDialog);
  }

  void removeBlankLinesHandler() {
    note.text = _textProcessingService.removeBlankLines (note.text);
    note.save();
  }

  void githubHandler() {
    window.location.href = "https://github.com/daftspaniel/np8080";
  }

  void downloadHandler() {
    note.save();
    String text = note.text;
    AnchorElement tl = document.createElement('a');
    tl
      ..attributes['href'] = 'data:text/plain;charset=utf-8,' +
          Uri.encodeComponent(text)
      ..attributes['download'] = note.downloadName
      ..click();
  }

  void generateHandler() {
    showGenerateDialog = true;
    showGenerateDialogChange.emit(showGenerateDialog);
  }

  void timestampHandler() {
    note.text += "\r\n" + new DateTime.now().toString();
    note.save();
  }

  void hide(int index) {
    display[index] = "none";
  }

  void show(int index) {
    display[index] = "block";
  }

  String getDisplay(int index) {
    if (display == null) return 'none';
    if (display.length == 0) return 'none';

    return display.elementAt(index);
  }
}