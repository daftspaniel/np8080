import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:np8080/dialog/common/dialog_base.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'sequence-dialog',
    templateUrl: 'sequence_component.html',
    directives: const [NgClass, NgModel, NgStyle, FORM_DIRECTIVES])
class SequenceDialogComponent extends NpEditDialogBase {

  @Input()
  TextDocument note;

  String _generatedText;

  num startIndex = 10;
  num repeatCount = 10;
  num increment = 10;
  int insertPos = -1;

  SequenceDialogComponent(TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newthemeService,
      EventBusService newEventBusService)
      :super(newTextProcessingService, newTextareaDomService, newthemeService,
      newEventBusService) {
    eventBusService.subscribe("showSequenceDialog", show);
  }

  void closeTheDialog() {
    close();
    textareaDomService.setFocus();
    if (insertPos > 0) {
      textareaDomService.setCursorPosition(insertPos);
    }
  }

  void prependText() {
    String newText = getGeneratedText() + '\n' + note.text;
    saveAndUpdateState(newText, note.text.length);
  }

  void appendText() {
    String newText = note.text + getGeneratedText();
    saveAndUpdateState(newText, note.text.length);
  }

  String getGeneratedText() {
    _generatedText = textProcessingService.getSequenceString(
        startIndex, repeatCount, increment);
    return _generatedText;
  }

  void insertCurrentPosition() {
    TextareaSelection selInfo = textareaDomService.getCurrentSelectionInfo();

    String newText = note.text.substring(0, selInfo.start) +
        getGeneratedText() +
        note.text.substring(selInfo.start);

    saveAndUpdateState(newText, selInfo.start);
  }

  void saveAndUpdateState(String newNoteText, int cursorPos) {
    note.updateAndSave(newNoteText);
    insertPos = cursorPos + _generatedText.length;
    closeTheDialog();
  }

  String getPreview() {
    return getGeneratedText();
  }

}