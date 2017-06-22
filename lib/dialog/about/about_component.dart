import '../../resources/resources.dart';

import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:np8080/dialog/common/dialog_base.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'about-dialog',
    templateUrl: 'about_component.html',
    directives: const [NgClass]
)
class AboutDialogComponent extends DialogBase {

  final ThemeService _themeService;
  final EventBusService _eventBusService;
  final String aboutText = welcomeText;

  AboutDialogComponent(this._eventBusService, this._themeService) {
    this._eventBusService.subscribe("showAboutDialog", show);
  }

  String getClass() {
    return _themeService.getMainClass();
  }

  String getHeaderClass() {
    return _themeService.getSecondaryClass();
  }
}