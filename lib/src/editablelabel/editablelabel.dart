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
    visibility: Visibility.none,
    templateUrl: 'editablelabel.html',
    directives: const [NgModel, NgStyle, NgClass, formDirectives])
class EditableLabel extends ComponentBase implements OnInit {
  final StreamController onTextChange = new StreamController();

  bool editMode = false;
  bool tabFocused = false;
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
    eventBusService.subscribe('resetEditableTable', reset);
  }

  ngOnInit() {
    formatText();
    eventBusService.subscribe('tabFocus$id', tabFocus);
    eventBusService.subscribe('tabFocusDone${id == 1 ? 2 : 1}', tabBlur);
  }

  void update() {
    onTextChange.add(text);
    formatText();
  }

  void formatText() {
    outputText = text.length < 18 ? text : text.substring(0, 15) + "...";
    document.title = text;
  }

  void giveTabFocus() {
    tabFocus();
    eventBusService.post("tabFocusDone$id");
  }

  void tabFocus() {
    tabFocused = true;
    print('tabFocused $id');
    print(tabFocused);
  }

  void tabBlur() {
    tabFocused = false;
    print('tabBlur $id');
    print(tabFocused);
    //eventBusService.post("tab$id");
  }

  void toggle() {
    editMode = !editMode;
    if (editMode) {
      TextInputElement tb = querySelector("#editbox");
      tb.focus();
    } else if (text.length == 0) {
      reset();
    }
  }

  void reset() {
    text = defaultDownloadName;
    update();
  }

  void clickTabXHandler() => eventBusService.post("closeEditorTabPrompt");

  String getTabsClass() => themeService.secondaryClass;
}
