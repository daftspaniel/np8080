import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:np8080/dialog/common/dialog_base.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'generate-dialog',
    templateUrl: 'generate_component.html',
    directives: const [NgClass, NgModel, NgStyle, NgClass, FORM_DIRECTIVES])
class GenerateDialogComponent extends NpEditDialogBase {

  @Input()
  TextDocument note;

  String textToRepeat;
  String _generatedText;

  num repeatCount = 10;
  int insertPos = -1;
  bool newLine = false;

  GenerateDialogComponent(TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newthemeService,
      EventBusService newEventBusService)
      :super(newTextProcessingService, newTextareaDomService, newthemeService,
      newEventBusService)  {
    eventBusService.subscribe("showGenerateDialog", show);
  }

  void closeTheDialog() {
    textToRepeat = "";
    close();
    textareaDomService.setFocus();
    if (insertPos > 0) {
      textareaDomService.setCursorPosition(insertPos);
    }
  }

  void appendText() {
    String newText = note.text + getGeneratedText();
    saveAndUpdateState(newText, note.text.length);
  }

  String getGeneratedText() {
    if (textToRepeat == null) return '';

    _generatedText = textProcessingService.getRepeatedString(
        textToRepeat, repeatCount, newLine);
    return _generatedText;
  }

  void insertCurrentPosition() {
    TextareaSelection selInfo = textareaDomService.getCurrentSelectionInfo();

    String newText = note.text.substring(0, selInfo.start) +
        getGeneratedText() +
        note.text.substring(selInfo.start);

    saveAndUpdateState(newText, selInfo.start);
  }

  void prependText() {
    String newText = getGeneratedText() + '\n' + note.text;
    saveAndUpdateState(newText, note.text.length);
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