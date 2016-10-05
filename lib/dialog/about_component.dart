import 'package:angular2/core.dart';

@Component(
    selector: 'about-dialog',
    templateUrl: 'about_component.html')
class AboutDialogComponent {
  @Input()
  bool showDialog = false;

  @Output()
  EventEmitter<bool> showDialogChange = new EventEmitter<bool>();

  void closeTheDialog() {
    showDialog = false;
    showDialogChange.emit(showDialog);
  }
}