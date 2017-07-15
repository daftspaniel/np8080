import 'package:angular/angular.dart';
import 'package:np8080/storage/localstorage.dart';
import 'package:np8080/storage/storagekeys.dart';

@Injectable()
class ThemeService {
  String _theme = 'default';

  String get theme {
    return _theme;
  }

  set theme(String newTheme) {
    _theme = newTheme;
    storeValue(SelectedThemeKey, newTheme);
  }

  String getMainClass() {
    return _theme + '-theme-1';
  }

  String getSecondaryClass() {
    return _theme + '-theme-2';
  }

  String getDocumentClass() {
    return _theme + '-document';
  }

  void load() {
    _theme = loadValue(SelectedThemeKey, 'default');
  }
}
