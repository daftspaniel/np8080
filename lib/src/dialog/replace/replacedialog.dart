import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:np8080/src/dialog/common/editorcomponentbase.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'replace-dialog',
    visibility: Visibility.none,
    templateUrl: 'replacedialog.html',
    directives: const [NgClass, NgModel, NgStyle, formDirectives])
class ReplaceDialog extends EditorComponentBase {
  String textToReplace;
  String replacementText;
  String updatedText;

  String _positionClass = "defaultpos";

  String get positionClass => _positionClass;

  ReplaceDialog(
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService) {
    eventBusService.subscribe("showReplaceDialog", initialiseAndShow);
  }

  void initialiseAndShow() {
    textToReplace = "";

    TextareaSelection tas = textareaDomService.getCurrentSelectionInfo();
    if (tas.text.length > 0) {
      textToReplace = tas.text;
      setFocus('#replaceTextbox');
    } else {
      setFocus('#targetTextbox');
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
