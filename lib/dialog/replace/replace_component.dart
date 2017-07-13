import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:np8080/dialog/common/dialog_base.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'replace-dialog',
    templateUrl: 'replace_component.html',
    directives: const [NgClass, NgModel, NgStyle, FORM_DIRECTIVES])
class ReplaceDialogComponent extends NpEditDialogBase
    implements OnChanges, AfterViewInit {

  @Input()
  TextDocument note;

  String textToReplace;
  String replacementText;
  bool newLine = false;
  String _updatedText;
  DivElement comp;
  int insertPos = -1;

  ReplaceDialogComponent(TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newthemeService,
      EventBusService newEventBusService)
      :super(newTextProcessingService, newTextareaDomService, newthemeService,
      newEventBusService) {
    eventBusService.subscribe("showReplaceDialog", show);
  }

  ngAfterViewInit() {
    handling();
  }

  handling() {
//    comp = querySelector("div[replacedialog]");
//    print(comp);
//    comp.onDragStart.listen((e) {
//      print("Drags");
//    });
//
//    comp.onDragEnd.listen((MouseEvent e) {
//      print("Drage");
//      print(e.client.x);
//      print(e.client.y);
//      move(e.client.x, e.client.y);
//    });
  }

//  void move(int mx, int my) {
//    comp.style.top = "${my}px";
//    comp.style.left = "${mx}px";
//  }

  void closeTheDialog() {
    textToReplace = "";
    close();
    textareaDomService.setFocus();
    if (insertPos > 0) {
      textareaDomService.setCursorPosition(insertPos);
    }
  }

  void appendText() {
    note.text += getUpdatedText();
    note.save();
  }

  String getUpdatedText() {
    _updatedText = textProcessingService.getReplaced(
        note.text, textToReplace, replacementText);
    return _updatedText;
  }

  void performReplace() {
    if (textToReplace.length > 0) {
      replacementText ??= "";
      if (newLine) {
        replacementText += "\n";
      }

      note.updateAndSave(getUpdatedText());
      closeTheDialog();
    }
  }

  void trackCursorPosition(int start) {
    insertPos = start + _updatedText.length;
  }

  @override
  ngOnChanges(Map<String, SimpleChange> changes) {
    TextareaSelection selInfo = textareaDomService.getCurrentSelectionInfo();
    insertPos = selInfo.start;
  }

}