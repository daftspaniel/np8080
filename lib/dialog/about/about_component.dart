import 'dart:async';
import '../../resources/resources.dart';

import 'package:angular2/core.dart';
import 'package:np8080/dialog/common/dialog_base.dart';
import 'package:np8080/services/eventbusservice.dart';

@Component(
    selector: 'about-dialog',
    templateUrl: 'about_component.html',
    providers: const [EventBusService])
class AboutDialogComponent extends DialogBase {
  final EventBusService _eventBusService;
  String aboutText = welcomeText;
  @Input()
  bool showDialog = false;

  @Output()
  Stream<bool> get showDialogChange => onShowDialogChange.stream;

  AboutDialogComponent(this._eventBusService) {
  }

  void closeTheDialog() {
    showDialog = false;
    onShowDialogChange.add(showDialog);
  }
}