import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:np8080/src/dialog/common/editorcomponentbase.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'prepost-dialog',
    preserveWhitespace: true,
    templateUrl: 'prepostdialog.html',
    directives: const [NgClass, NgModel, NgStyle, formDirectives])
class PrePostDialog extends EditorComponentBase {
  String prefix = "";
  String postfix = "";

  PrePostDialog(
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService) {
    eventBusService.subscribe("showPrePostDialog", initialiseAndShow);
  }

  void initialiseAndShow() {
    show();
    setFocus('#preTextbox');
  }

  void performPrePost() {
    if (prefix.length + postfix.length > 0) {
      String txt = note.text;
      if (prefix.length > 0)
        txt = textProcessingService.prefixLines(txt, prefix);
      if (postfix.length > 0)
        txt = textProcessingService.postfixLines(txt, postfix);

      note.updateAndSave(txt);
      closeTheDialog();
    }
  }
}
