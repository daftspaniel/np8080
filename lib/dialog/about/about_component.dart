import '../../resources/resources.dart';

import 'package:angular2/core.dart';
import 'package:np8080/dialog/common/dialog_base.dart';
import 'package:np8080/services/eventbusservice.dart';

@Component(
    selector: 'about-dialog',
    templateUrl: 'about_component.html')
class AboutDialogComponent extends DialogBase {

  final EventBusService _eventBusService;
  final String aboutText = welcomeText;

  @Input()
  bool showDialog = false;

  AboutDialogComponent(this._eventBusService) {
    this._eventBusService.subscribe("showAboutDialog", () {
      showDialog = true;
    });
  }

  void closeTheDialog() {
    showDialog = false;
  }
}