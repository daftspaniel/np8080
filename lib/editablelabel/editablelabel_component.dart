import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/src/platform/browser/title.dart';

@Component(
    selector: 'editable-label',
    templateUrl: 'editablelabel_component.html'
)
class EditableLabelComponent implements OnInit {

  bool editMode = false;
  String outputText;
  Title _title = new Title();

  @Input()
  String text;

  @Output()
  EventEmitter<String> textChange = new EventEmitter<String>();

  EditableLabelComponent() {
    editMode = false;
  }

  void update() {
    textChange.emit(text);
    formatText();
  }

  void formatText() {
    outputText = text.length < 18 ? text : text.substring(0, 15) + "...";
    _title.setTitle(text);
  }

  void toggle() {
    editMode = !editMode;
    if (editMode) {
      TextInputElement tb = querySelector("#editbox");
      tb.focus();
    }
    else {
      if (text.length == 0) {
        text = "np8080.txt";
        update();
      }
    }
  }

  @override
  ngOnInit() {
    formatText();
  }
}