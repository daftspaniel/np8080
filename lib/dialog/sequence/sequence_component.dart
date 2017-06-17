import 'package:angular2/angular2.dart' show NgStyle, NgModel, FORM_DIRECTIVES;
import 'package:angular2/core.dart';
import 'package:np8080/dialog/common/dialog_base.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';

@Component(
    selector: 'sequence-dialog',
    templateUrl: 'sequence_component.html',
    directives: const [NgModel, NgStyle, FORM_DIRECTIVES])
class SequenceDialogComponent extends DialogBase {

  final EventBusService _eventBusService;

  @Input()
  TextDocument note;

  String textToRepeat;
  String _generatedText;

  num startIndex = 10;
  num repeatCount = 10;
  num increment = 10;
  int insertPos = -1;

  final TextProcessingService _textProcessingService;
  final TextareaDomService _textareaDomService;

  SequenceDialogComponent(this._textProcessingService,
      this._textareaDomService, this._eventBusService){
    this._eventBusService.subscribe("showSequenceDialog", show);
  }

  void closeTheDialog() {
    textToRepeat = "";
    close();
    _textareaDomService.setFocus();
    if (insertPos > 0) {
      _textareaDomService.setCursorPosition(insertPos);
    }
  }

  void appendText() {
    String newText = note.text + getGeneratedText();
    saveAndUpdateState(newText, note.text.length);
  }

  String getGeneratedText() {
    _generatedText = _textProcessingService.getSequenceString(
        startIndex, repeatCount, increment);
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
    note.updateAndSave(newNoteText);
    insertPos = cursorPos + _generatedText.length;
  }

}