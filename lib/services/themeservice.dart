import 'package:angular2/core.dart';

@Injectable()
class ThemeService {
  String baseColor = "#FCFCFC";
  String textColor = "#000000";

  String theme = 'default';

  String getMainClass() {
    return theme+'-theme-1';
  }

  String getSecondaryClass() {
    return theme+'-theme-2';
  }

  String getDocumentClass() {
    return theme+'-document';
  }

}