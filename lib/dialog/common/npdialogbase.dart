import 'package:angular/angular.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';
import 'dialog_base.dart';

@Component(selector: 'base_dialog',
    templateUrl: '../about/about_component.html',
    directives: const [NgClass, NgModel, NgStyle, FORM_DIRECTIVES])
class NpEditDialogBase extends DialogBase {

  final TextProcessingService textProcessingService;
  final TextareaDomService textareaDomService;

  @Input()
  TextDocument note;

  int insertPos = -1;
  String generatedText;

  NpEditDialogBase(this.textProcessingService,
      this.textareaDomService,
      ThemeService newthemeService,
      EventBusService newEventBusService)
      :super(newthemeService, newEventBusService) {
  }

  void closeTheDialog() {
    close();
    textareaDomService.setFocus();
    if (insertPos > 0) {
      textareaDomService.setCursorPosition(insertPos);
    }
  }

  String getGeneratedText() {
    return '';
  }
  String getUpdatedText() {
    return '';
  }

  void ammendText() {
    note.text = getUpdatedText();
    note.save();
  }

  void appendText() {
    String newText = note.text + getGeneratedText();
    saveAndUpdateState(newText, note.text.length);
  }

  void prependText() {
    String newText = getGeneratedText() + '\n' + note.text;
    saveAndUpdateState(newText, note.text.length);
  }

  void saveAndUpdateState(String newNoteText, int cursorPos) {
    note.updateAndSave(newNoteText);
    insertPos = cursorPos + generatedText.length;
    closeTheDialog();
  }

  void insertCurrentPosition() {
    TextareaSelection selInfo = textareaDomService.getCurrentSelectionInfo();

    String newText = note.text.substring(0, selInfo.start) +
        getGeneratedText() +
        note.text.substring(selInfo.start);

    saveAndUpdateState(newText, selInfo.start);
  }

  String getPreview() {
    return getGeneratedText();
  }
}
