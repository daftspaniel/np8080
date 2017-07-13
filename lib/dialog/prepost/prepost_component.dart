import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:np8080/dialog/common/dialog_base.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'prepost-dialog',
    templateUrl: 'prepost_component.html',
    directives: const [NgClass, NgModel, NgStyle, FORM_DIRECTIVES])
class PrePostDialogComponent extends NpEditDialogBase {

  @Input()
  TextDocument note;

  String prefix = "";
  String postfix = "";

  PrePostDialogComponent(TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newthemeService,
      EventBusService newEventBusService)
      :super(newTextProcessingService, newTextareaDomService, newthemeService,
      newEventBusService) {
    eventBusService.subscribe("showPrePostDialog", show);
  }

  void closeTheDialog() {
    close();
    textareaDomService.setFocus();
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