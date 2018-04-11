import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:np8080/src/document/textdocument.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/themeservice.dart';
import 'componentbase.dart';

@Component(
    selector: 'base_dialog',
    template: '',
    directives: [NgClass, NgModel, NgStyle, formDirectives])
class EditorComponentBase extends ComponentBase {
  final TextProcessingService textProcessingService;
  final TextareaDomService textareaDomService;

  bool get showDialog => showComponent;

  @Input()
  TextDocument note;

  int insertPos = -1;
  String generatedText;

  bool newLineAfter = false;
  bool newLineBefore = false;

  EditorComponentBase(this.textProcessingService, this.textareaDomService,
      ThemeService newthemeService, EventBusService newEventBusService)
      : super(newthemeService, newEventBusService) {}

  void closeTheDialog() {
    close();
    textareaDomService.setFocus();
    if (insertPos > 0) {
      textareaDomService.setCursorPosition(insertPos);
    }
  }

  String getGeneratedText() => '';

  String getUpdatedText() => '';

  String getPreview() => getGeneratedText();

  void amendText() => note.updateAndSave(getUpdatedText());

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
}
