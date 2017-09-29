import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:np8080/src/dialog/common/editorcomponentbase.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'delete-lines-dialog',
    visibility: Visibility.none,
    templateUrl: 'deletelinesdialog.html',
    directives: const [NgModel, NgClass, formDirectives])
class DeleteLinesDialog extends EditorComponentBase {
  String markerText;
  String updatedText;
  String containOption = 'containing';

  DeleteLinesDialog(
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService) {
    eventBusService.subscribe("showDeleteLinesDialog", initialiseAndShow);
  }

  void initialiseAndShow() {
    markerText = "";
    setFocus("#markerTextbox");
    show();
  }

  String getUpdatedText() {
    if (containOption.indexOf('NOT') < 0) {
      updatedText =
          textProcessingService.deleteLinesContaining(note.text, markerText);
    } else {
      updatedText =
          textProcessingService.deleteLinesNotContaining(note.text, markerText);
    }
    return updatedText;
  }

  void performDelete() {
    if (markerText.length > 0) {
      note.updateAndSave(getUpdatedText());
    }
  }
}
