import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:np8080/src/dialog/common/componentbase.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'themes-dialog',
    visibility: Visibility.none,
    templateUrl: 'themesdialog.tpl.html',
    directives: const [NgClass, NgModel, NgStyle, formDirectives])
class ThemesDialog extends ComponentBase {
  String theme;

  ThemesDialog(ThemeService newThemeService, EventBusService newEventBusService)
      : super(newThemeService, newEventBusService) {
    eventBusService.subscribe("showThemesDialog", initialiseAndShow);
    theme = themeService.theme;
  }

  void initialiseAndShow() {
    show();
  }

  void change() {
    themeService.theme = theme;
  }
}
