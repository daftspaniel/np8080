import 'package:angular/angular.dart';

import 'package:np8080/src/dialog/common/editorcomponentbase.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'delete-lines-dialog',
    templateUrl: 'deletelines_component.html',
    directives: const [NgModel, NgClass, FORM_DIRECTIVES])
class DeleteLinesDialogComponent extends EditorComponentBase {
  String markerText;
  String updatedText;
  String containOption = 'containing';

  DeleteLinesDialogComponent(
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
