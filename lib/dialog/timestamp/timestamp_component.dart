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
    directives: const [
      NgFor, NgClass, NgModel, NgStyle, NgSelectOption, FORM_DIRECTIVES])
class TimestampDialogComponent extends DialogBase {

  final EventBusService _eventBusService;
  final ThemeService _themeService;

  @Input()
  TextDocument note;

  List<String> times = new List<String>();

  String timeStamp = '';

  int insertPos = -1;

  final TextareaDomService _textareaDomService;

  TimestampDialogComponent(this._textareaDomService,
      this._eventBusService,
      this._themeService) {
    _eventBusService.subscribe("showTimestampDialog", show);
    updateTime();
    timeStamp = times[0];
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

  void prependText() {
    String newText = getSelectedTimestamp() + '\n' + note.text;
    saveAndUpdateState(newText, note.text.length);
  }

  String getSelectedTimestamp() {
    return timeStamp;
  }

  void updateTime() {
    DateTime ourtime = new DateTime.now();
    times = [
      ourtime.toString(),
      new DateFormat('EEEE h:m a').format(ourtime),
      new DateFormat('EEEE H:m').format(ourtime),
      new DateFormat('yyyy-MM-dd').format(ourtime),
      new DateFormat('h:m:ss').format(ourtime),
      new DateFormat('H:m:ss').format(ourtime),
      new DateFormat('EEEE H:m:ss').format(ourtime),
      new DateFormat('EEEE h:m:ss a').format(ourtime),
    ];
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
    insertPos = cursorPos + timeStamp.length;
    closeTheDialog();
  }


  String getClass() {
    return _themeService.getMainClass();
  }

  String getHeaderClass() {
    return _themeService.getSecondaryClass();
  }
}