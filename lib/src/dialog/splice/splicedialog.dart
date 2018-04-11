import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:np8080/src/dialog/common/editorcomponentbase.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'splice-dialog',
    preserveWhitespace: true,
    templateUrl: 'splicedialog.html',
    directives: [NgClass, NgModel, NgStyle, formDirectives])
class SpliceDialog extends EditorComponentBase {
  int startSplice = 0;
  int endSplice = 0;

  SpliceDialog(
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService) {
    eventBusService.subscribe("showSpliceDialog", initialiseAndShow);
  }

  void initialiseAndShow() {
    show();
    setFocus('#preTextbox');
  }

  void performSplice() {
    String txt = note.text;
    if (endSplice == 0) {
      txt = textProcessingService.splice(txt, startSplice);
    } else {
      txt = textProcessingService.splice(txt, startSplice, endSplice);
    }
    note.updateAndSave(txt);
    closeTheDialog();
  }
}
