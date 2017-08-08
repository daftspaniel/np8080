import 'package:angular/angular.dart';
import 'package:np8080/src/dialog/common/editorcomponentbase.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/inputfocusservice.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'split-dialog',
    templateUrl: 'splitdialog.tpl.html',
    directives: const [NgClass, NgModel, NgStyle, formDirectives])
class SplitDialog extends EditorComponentBase {
  InputFocusService inputFocusService;
  String delimiter;
  String replacementText;
  String updatedText;

  SplitDialog(
      InputFocusService newInputFocusService,
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService) {
    eventBusService.subscribe("showSplitDialog", initialiseAndShow);
    inputFocusService = newInputFocusService;
  }

  void initialiseAndShow() {
    delimiter = "";

    TextareaSelection tas = textareaDomService.getCurrentSelectionInfo();
    if (tas.text.length > 0) {
      delimiter = tas.text;
    }
    inputFocusService.setFocus('#delimiterTextbox');
    show();
  }

  String getUpdatedText() {
    updatedText = textProcessingService.split(note.text, delimiter);
    return updatedText;
  }

  void performSplit() {
    note.updateAndSave(getUpdatedText());
    closeTheDialog();
  }
}
