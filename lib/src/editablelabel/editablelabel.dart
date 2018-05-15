import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:np8080/src/dialog/common/componentbase.dart';
import 'package:np8080/src/document/textdocument.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'editable-label',
    templateUrl: 'editablelabel.html',
    directives: [NgModel, NgStyle, NgClass, formDirectives])
class EditableLabel extends ComponentBase implements OnInit {
  final onTextChange = StreamController<String>();

  var editMode = false;
  var tabFocused = false;
  String outputText;

  @Input()
  String text;

  @Input()
  int id;

  @Output()
  Stream<String> get textChange => onTextChange.stream;

  EditableLabel(
      ThemeService newthemeService, EventBusService newEventBusService)
      : super(newthemeService, newEventBusService) {
    editMode = false;
    eventBusService.subscribe('resetEditableLabel', reset);
  }

  ngOnInit() {
    formatText();
    eventBusService.subscribe('tabFocus$id', tabFocus);
    if (id != 1) eventBusService.subscribe('tabFocusDone1', tabBlur);
    if (id != 2) eventBusService.subscribe('tabFocusDone2', tabBlur);
    if (id != 3) eventBusService.subscribe('tabFocusDone3', tabBlur);
    if (id != 4) eventBusService.subscribe('tabFocusDone4', tabBlur);
    if (id != 5) eventBusService.subscribe('tabFocusDone5', tabBlur);
    if (id != 6) eventBusService.subscribe('tabFocusDone6', tabBlur);
  }

  void update() {
    onTextChange.add(text);
    formatText();
  }

  void formatText() {
    outputText = text.length < 18 ? text : text.substring(0, 15) + "...";
    if (tabFocused) {
      document.title = text;
    }
  }

  void giveTabFocus() {
    if (tabFocused) return;
    tabFocus();
    eventBusService.post("tabFocusDone$id");
  }

  void tabFocus() {
    tabFocused = true;
    editMode = false;
  }

  void tabBlur() {
    tabFocused = false;
    editMode = false;
  }

  String getTabsClass() => themeService.secondaryClass;

  void exitEdit() {
    editMode = false;
  }

  void toggle() {
    editMode = !editMode;
    if (editMode) {
      var tb = querySelector("#editbox$id");
      tb.focus();
    } else if (text.length == 0) {
      reset();
    }
  }

  void reset() {
    text = defaultDownloadName;
    update();
  }
}
