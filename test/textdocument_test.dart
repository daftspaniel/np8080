import 'package:np8080/src/document/textdocument.dart';
import 'package:np8080/src/resources/resources.dart';

import 'package:test/test.dart';

void main() {
  TextDocument tdoc = new TextDocument();

  group('Document core:', () {
    test('default not empty', () {
      expect(tdoc.empty, false);
    });
    test('default welcome text', () {
      expect(tdoc.text, welcomeText);
    });
    test('default filename is set', () {
      expect(tdoc.downloadName, 'np8080.txt');
    });
    test('text can be set', () {
      tdoc.updateAndSave('Hello world!');
      expect(tdoc.text, 'Hello world!');
    });
    test('downloadname can be set', () {
      tdoc.downloadName = 'testnp8080.doc';
      expect(tdoc.downloadName, 'testnp8080.doc');
    });
  });
}
