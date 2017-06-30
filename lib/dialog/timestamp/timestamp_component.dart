import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:intl/intl.dart';
import 'package:np8080/dialog/common/dialog_base.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'timestamp-dialog',
    templateUrl: 'timestamp_component.html',
    directives: const [NgClass, NgModel, NgStyle, FORM_DIRECTIVES])
class TimestampDialogComponent extends DialogBase {

  final EventBusService _eventBusService;
  final ThemeService _themeService;

  @Input()
  TextDocument note;

  String _generatedText;

  int insertPos = -1;

  final TextareaDomService _textareaDomService;

  TimestampDialogComponent(this._textareaDomService,
      this._eventBusService,
      this._themeService) {
    this._eventBusService.subscribe("showTimestampDialog", show);
  }

  void closeTheDialog() {
    close();
    _textareaDomService.setFocus();
    if (insertPos > 0) {
      _textareaDomService.setCursorPosition(insertPos);
    }
  }

  void appendText() {
    String newText = note.text + getSelectedTimestamp();
    saveAndUpdateState(newText, note.text.length);
  }

  String getSelectedTimestamp() {
//    if (textToRepeat == null) return '';
//
//    _generatedText = _textProcessingService.getRepeatedString(
//        textToRepeat, repeatCount, newLine);
//    return _generatedText;
    return "1234";
  }

  String basic = new DateTime.now().toString();
  String day = new DateFormat('EEEE h:m').format(new DateTime.now());
  String day24 = new DateFormat('EEEE H:m').format(new DateTime.now());
  String date = new DateFormat('yyyy-MM-dd').format(new DateTime.now());
  String ftime = new DateFormat('h:m:s').format(new DateTime.now());
  String f24time = new DateFormat('Hms').format(new DateTime.now());

  String getTimestamp() {
    return basic;
  }

  void insertCurrentPosition() {
    TextareaSelection selInfo = _textareaDomService.getCurrentSelectionInfo();

    String newText = note.text.substring(0, selInfo.start) +
        getSelectedTimestamp() +
        note.text.substring(selInfo.start);

    saveAndUpdateState(newText, selInfo.start);
  }

  void saveAndUpdateState(String newNoteText, int cursorPos) {
    note.updateAndSave(newNoteText);
    insertPos = cursorPos + _generatedText.length;
  }

  String getPreview() {
    return getSelectedTimestamp();
  }

  String getClass() {
    return _themeService.getMainClass();
  }

  String getHeaderClass() {
    return _themeService.getSecondaryClass();
  }
}