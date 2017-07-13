import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:intl/intl.dart';
import 'package:np8080/dialog/common/npdialogbase.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'timestamp-dialog',
    templateUrl: 'timestamp_component.html',
    directives: const [
      NgFor, NgClass, NgModel, NgStyle, NgSelectOption, FORM_DIRECTIVES])
class TimestampDialogComponent extends NpEditDialogBase {

  @Input()
  TextDocument note;

  final List<String> times = new List<String>();

  String timeStamp = '';

  int insertPos = -1;

  TimestampDialogComponent(TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newthemeService,
      EventBusService newEventBusService)
      :super(newTextProcessingService, newTextareaDomService, newthemeService,
      newEventBusService) {
    eventBusService.subscribe("showTimestampDialog", show);
    updateTime();
    timeStamp = times[0];
  }

  void closeTheDialog() {
    close();
    textareaDomService.setFocus();
    if (insertPos > 0) {
      textareaDomService.setCursorPosition(insertPos);
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
    DateTime currentTime = new DateTime.now();
    times.clear();
    times.addAll([
      currentTime.toString(),
      formatDateTime(currentTime, 'EEEE h:m a'),
      formatDateTime(currentTime, 'EEEE H:m'),
      formatDateTime(currentTime, 'yyyy-MM-dd'),
      formatDateTime(currentTime, 'h:m:ss'),
      formatDateTime(currentTime, 'H:m:ss'),
      formatDateTime(currentTime, 'EEEE H:m:ss'),
      formatDateTime(currentTime, 'EEEE h:m:ss a')
    ]);
  }

  String formatDateTime(DateTime dateTime, String pattern) {
    return new DateFormat(pattern).format(dateTime);
  }

  void insertCurrentPosition() {
    TextareaSelection selInfo = textareaDomService.getCurrentSelectionInfo();

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
}