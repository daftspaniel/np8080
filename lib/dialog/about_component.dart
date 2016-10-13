import 'package:angular2/core.dart';
import 'package:np8080/dialog/dialog_base.dart';

@Component(
    selector: 'about-dialog',
    templateUrl: 'about_component.html')
class AboutDialogComponent extends DialogBase {
  @Input()
  bool showDialog = false;

  @Output()
  EventEmitter<bool> showDialogChange = new EventEmitter<bool>();

  void closeTheDialog() {
    showDialog = false;
    showDialogChange.emit(showDialog);
  }
}