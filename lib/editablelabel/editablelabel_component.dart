import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'editable-label',
    templateUrl: 'editablelabel_component.html',
    directives: const [NgModel, NgStyle, NgClass, FORM_DIRECTIVES])
class EditableLabelComponent implements OnInit {
  final StreamController onTextChange = new StreamController();
  final ThemeService _themeService;

  bool editMode = false;
  String outputText;

  @Input()
  String text;

  @Output()
  Stream<String> get textChange => onTextChange.stream;

  EditableLabelComponent(this._themeService) {
    editMode = false;
  }

  void update() {
    onTextChange.add(text);
    formatText();
  }

  void formatText() {
    outputText = text.length < 18 ? text : text.substring(0, 15) + "...";
    document.title = text;
  }

  void toggle() {
    editMode = !editMode;
    if (editMode) {
      TextInputElement tb = querySelector("#editbox");
      tb.focus();
    } else {
      if (text.length == 0) {
        text = "np8080.txt";
        update();
      }
    }
  }

  String getTabsClass() => _themeService.getSecondaryClass();

  ngOnInit() {
    formatText();
  }
}
