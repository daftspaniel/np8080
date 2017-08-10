import 'package:angular/angular.dart';
import 'package:np8080/src/dialog/common/editorcomponentbase.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/inputfocusservice.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'replace-dialog',
    templateUrl: 'replace_component.html',
    directives: const [NgClass, NgModel, NgStyle, formDirectives])
class ReplaceDialogComponent extends EditorComponentBase {
  InputFocusService inputFocusService;
  String textToReplace;
  String replacementText;
  String updatedText;

  String _positionClass = "defaultpos";

  String get positionClass => _positionClass;

  ReplaceDialogComponent(
      InputFocusService newInputFocusService,
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService) {
    eventBusService.subscribe("showReplaceDialog", initialiseAndShow);
    inputFocusService = newInputFocusService;
  }

  void initialiseAndShow() {
    textToReplace = "";

    TextareaSelection tas = textareaDomService.getCurrentSelectionInfo();
    if (tas.text.length > 0) {
      textToReplace = tas.text;
      inputFocusService.setFocus('#replaceTextbox');
    } else {
      inputFocusService.setFocus('#targetTextbox');
    }
    show();
  }

  String getUpdatedText() {
    updatedText = textProcessingService.getReplaced(
        note.text, textToReplace, replacementText);
    return updatedText;
  }

  void performReplace() {
    if (textToReplace.length > 0) {
      replacementText ??= "";
      if (newLineAfter) {
        replacementText += "\n";
      }
      if (newLineBefore) {
        replacementText = "\n$replacementText";
      }

      amendText();
    }
  }

  void moveTheDialog(bool moveDown) =>
      _positionClass = moveDown ? 'defaultpos' : 'leftpos';
}
