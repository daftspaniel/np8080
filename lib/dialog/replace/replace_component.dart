import 'package:angular/angular.dart';
import 'package:np8080/dialog/common/npdialogbase.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'replace-dialog',
    templateUrl: 'replace_component.html',
    directives: const [NgClass, NgModel, NgStyle, FORM_DIRECTIVES])
class ReplaceDialogComponent extends NpEditDialogBase {

  String textToReplace;
  String replacementText;
  String updatedText;

  String _positionClass = "defaultpos";

  String get positionClass => _positionClass;

  ReplaceDialogComponent(TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      :super(newTextProcessingService, newTextareaDomService, newThemeService,
      newEventBusService) {
    eventBusService.subscribe("showReplaceDialog", initialiseAndShow);
  }

  void initialiseAndShow() {
    textToReplace = "";
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