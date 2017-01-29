import 'package:angular2/core.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';

@Component(
    selector: 'generate-dialog',
    templateUrl: 'generate_component.html',
    providers: const [TextProcessingService, TextareaDomService])
class GenerateDialogComponent implements OnInit {
  @Input()
  bool showDialog = false;

  @Input()
  TextDocument note;

  @Output()
  EventEmitter<bool> showDialogChange = new EventEmitter<bool>();

  String textToRepeat;
  String _generatedText;
  List<String> _undoText = new List<String>();
  List<int> _undoPositions = new List<int>();

  int repeatCount = 10;
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

  void undoTextGeneration() {
    if (_undoText.length == 0) return;
    saveAndUpdateState(_undoText.removeLast(), _undoPositions.removeLast());
  }

  void appendText() {
    String newText = note.text + getGeneratedText();
    saveAndUpdateState(newText, note.text.length);
  }

  String getGeneratedText() {
    _generatedText = _textProcessingService.getRepeatedString(
        textToRepeat, repeatCount);
    return _generatedText;
  }

  void insertCurrentPosition() {
    TextareaSelection selInfo = _textareaDomService.getCurrentSelectionInfo();

    String newText = note.text.substring(0, selInfo.start) +
        getGeneratedText() +
        note.text.substring(selInfo.start);

    saveAndUpdateState(newText, selInfo.start);
  }

  void saveAndUpdateState(String newNoteText, int cursorPos) {
    storeStateForUndo(cursorPos);
    note.text = newNoteText;
    note.save();
    insertPos = cursorPos + _generatedText.length;
  }

  void storeStateForUndo(int cursorPos) {
    _undoText.add(note.text);
    _undoPositions.add(cursorPos);
  }

  @override
  ngOnInit() {
//    TextareaSelection selInfo = _textareaDomService.getCurrentSelectionInfo();
//    storeStateForUndo(selInfo.start);
  }
}