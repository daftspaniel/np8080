import 'package:angular/angular.dart';

import 'package:np8080/dialog/common/npdialogbase.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'delete-lines-dialog',
    templateUrl: 'deletelines_component.html',
    directives: const[NgModel, NgClass, FORM_DIRECTIVES]
)
class DeleteLinesDialogComponent extends NpEditDialogBase {

  String markerText;
  String updatedText;

  DeleteLinesDialogComponent(TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      :super(newTextProcessingService, newTextareaDomService, newThemeService,
      newEventBusService) {
    eventBusService.subscribe("showDeleteLinesDialog", initialiseAndShow);
  }

  void initialiseAndShow() {
    markerText = "";
    show();
  }

  String getUpdatedText() {
    updatedText =
        textProcessingService.deleteLinesContaining(note.text, markerText);
    return updatedText;
  }

  void performDelete() {
    if (markerText.length > 0) {
      note.updateAndSave(getUpdatedText());
    }
  }
}