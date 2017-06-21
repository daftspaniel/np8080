import 'package:np8080/services/textprocessingservice.dart';
import 'package:test/test.dart';

void main() {
  TextProcessingService tps = new TextProcessingService();

  // Testing now in stringprocess package. 1 test remaining to test Service version.
  group('Generate:', () {

    test('getRepeatedString', () {
      expect(tps.getRepeatedString("Moo", 4), "MooMooMooMoo");
      expect(tps.getRepeatedString("Moo", 0), "");
    });
  });
}
