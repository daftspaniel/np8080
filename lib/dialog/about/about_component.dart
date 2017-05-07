import 'dart:async';
import '../../resources/resources.dart';
import 'package:angular2/core.dart';
import 'package:np8080/dialog/common/dialog_base.dart';

@Component(
    selector: 'about-dialog',
    templateUrl: 'about_component.html')
class AboutDialogComponent extends DialogBase {

  String aboutText = welcomeText;
  @Input()
  bool showDialog = false;

  @Output()
  Stream<bool> get showDialogChange => onShowDialogChange.stream;

  void closeTheDialog() {
    showDialog = false;
    onShowDialogChange.add(showDialog);
  }
}