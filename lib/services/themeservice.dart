import 'package:angular2/core.dart';

@Injectable()
class ThemeService {
  String baseColor = "#FCFCFC";
  String textColor = "#000000";

  String getMainClass() {
    return 'default-theme-1';
  }

  String getSecondaryClass() {
    return 'default-theme-2';
  }

}