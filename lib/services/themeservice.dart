import 'package:angular2/core.dart';

@Injectable()
class ThemeService {
  String baseColor = "#FCFCFC";
  String textColor = "#000000";

  String getThemeClass() {
    return 'default-theme';
  }
}