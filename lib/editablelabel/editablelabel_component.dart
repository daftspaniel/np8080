import 'package:angular2/core.dart';

@Component(
    selector: 'editable-label',
    templateUrl: 'editablelabel_component.html'
)
class EditableLabelComponent implements OnInit {

  bool editMode = false;
  String outputText;

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
  }

  @HostListener('blur')
  void toggle() {
    editMode = !editMode;
  }

  @override
  ngOnInit() {
    formatText();
  }
}