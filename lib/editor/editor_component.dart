import 'package:angular2/core.dart';
import 'package:angular2/src/facade/browser.dart';
import 'package:np8080/dialog/about/about_component.dart';
import 'package:np8080/dialog/generate/generate_component.dart';
import 'package:np8080/dialog/prepost/prepost_component.dart';
import 'package:np8080/dialog/replace/replace_component.dart';
import 'package:np8080/dialog/sequence/sequence_component.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/editor/preview_component.dart';
import 'package:np8080/editor/status_component.dart';
import 'package:np8080/resources/resources.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/toolbar/toolbar_component.dart';

@Component(
    selector: 'plain-editor',
    templateUrl: 'editor_component.html',
    directives: const [
      StatusComponent,
      ToolbarComponent,
      AboutDialogComponent,
      GenerateDialogComponent,
      ReplaceDialogComponent,
      PrePostDialogComponent,
      SequenceDialogComponent,
      PreviewComponent
    ],
    providers: const [TextareaDomService, TextProcessingService])
class EditorComponent {
  final TextareaDomService _textareaDomService;
  final TextProcessingService _textProcessingService;

  List<String> _undoText = new List<String>();
  List<int> _undoPositions = new List<int>();

  EditorComponent(this._textareaDomService, this._textProcessingService);

  @Input()
  TextDocument note;

  bool showAboutDialog = false;

  bool showGenerateDialog = false;

  bool showSeqDialog = false;

  bool showReplaceDialog = false;

  bool showPreview = false;

  bool showPrePostDialog = false;

  final String placeHolderText = editorPlaceHolderText;

  void changeHandler() {
    note.save();
  }

  bool keyHandler(KeyboardEvent e) {
    // TAB key
    if (e.keyCode == 9) {
      e.preventDefault();
      TextareaSelection selInfo = _textareaDomService.getCurrentSelectionInfo();

      if (selInfo.text.length > 0) {
        String out = note.text.substring(0, selInfo.start);
        String tabbedText = _textProcessingService.prefixLines(
            selInfo.text, tab);
        out += tabbedText;
        out += note.text.substring(selInfo.end);
        _textareaDomService.setText(out);
        _textareaDomService.setCursorPosition(
            selInfo.start + tabbedText.length);
      }
      else {
        _textareaDomService.setText(
            note.text.substring(0, selInfo.start) +
                tab +
                note.text.substring(selInfo.end));
        _textareaDomService.setCursorPosition(selInfo.start + tab.length);
      }

      note.updateAndSave(_textareaDomService.getText());
      return false;
    }

    return true;
  }

  void undoTextGeneration() {
    if (_undoText.length == 0) return;
    //saveAndUpdateState(_undoText.removeLast(), _undoPositions.removeLast());
  }

  void storeStateForUndo(int cursorPos) {
    _undoText.add(note.text);
    _undoPositions.add(cursorPos);
  }
}