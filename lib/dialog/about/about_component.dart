import '../../resources/resources.dart';

import 'package:angular/angular.dart';

import 'package:np8080/dialog/common/componentbase.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'about-dialog',
    templateUrl: 'about_component.html',
    directives: const [NgClass]
)
class AboutDialogComponent extends ComponentBase {

  final String aboutText = welcomeText;

  AboutDialogComponent(ThemeService newthemeService,
      EventBusService newEventBusService)
      :super(newthemeService, newEventBusService) {
    eventBusService.subscribe("showAboutDialog", show);
  }

}