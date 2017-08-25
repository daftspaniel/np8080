import 'package:angular/angular.dart';

import 'package:np8080/src/dialog/common/componentbase.dart';
import 'package:np8080/src/resources/resources.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'manual-dialog',
    visibility: Visibility.none,
    templateUrl: 'manual.tpl.html',
    directives: const [NgClass])
class ManualDialog extends ComponentBase {
  String manualText;

  ManualDialog(ThemeService newthemeService, EventBusService newEventBusService)
      : super(newthemeService, newEventBusService) {
    eventBusService.subscribe("showManualDialog", showManual);
  }

  void showManual() {
    manualText = np8080Manual;
    show();
  }
}
