import 'package:angular2/core.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';

@Component(
    selector: 'generate-dialog',
    templateUrl: 'generate_component.html',
    providers: const [TextProcessingService, TextareaDomService])
class GenerateDialogComponent {
  @Input()
  bool showDialog = false;

  @Input()
  TextDocument note;

  @Output()
  EventEmitter<bool> showDialogChange = new EventEmitter<bool>();

  String textToRepeat;
  String _generatedText;
  List<String> _undoList = new List<String>();

  num repeatCount = 10;
  int insertPos = -1;

  final TextProcessingService _textProcessingService;
  final TextareaDomService _textareaDomService;

  GenerateDialogComponent(this._textProcessingService,
      this._textareaDomService);

  void closeTheDialog() {
    textToRepeat = "";
    showDialog = false;
    showDialogChange.emit(showDialog);
    _textareaDomService.setFocus();
    if (insertPos > 0) {
      _textareaDomService.setCursorPosition(insertPos);
    }
  }

  void appendText() {
    note.text += getGeneratedText();
    saveAndUpdateState(note.text.length);
  }

  String getGeneratedText() {
    _generatedText = _textProcessingService.getRepeatedString(
        textToRepeat, repeatCount);
    return _generatedText;
  }

  void insertCurrentPosition() {
    TextareaSelection selInfo = _textareaDomService.getCurrentSelectionInfo();

    note.text = note.text.substring(0, selInfo.start) + getGeneratedText() +
        note.text.substring(selInfo.start);

    saveAndUpdateState(selInfo.start);
  }

  void saveAndUpdateState(int cursorPos) {
    trackCursorPosition(cursorPos);
    note.save();
    _undoList.add(note.text);
  }

  void trackCursorPosition(int start) {
    insertPos = start + _generatedText.length;
  }
}