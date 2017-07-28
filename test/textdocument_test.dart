import 'package:np8080/src/document/textdocument.dart';
import 'package:np8080/src/resources/resources.dart';

import 'package:test/test.dart';

void main() {
  group('Document core:', () {
    TextDocument tdoc;
    setUp(() {
      tdoc = new TextDocument();
    });
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
      tdoc.text = 'Hello world!';
      expect(tdoc.text, 'Hello world!');
    });
    test('text can be updated and saved', () {
      tdoc.updateAndSave('Hello world again!');
      expect(tdoc.text, 'Hello world again!');
    });
    test('downloadname can be set', () {
      tdoc.downloadName = 'testnp8080.doc';
      expect(tdoc.downloadName, 'testnp8080.doc');
    });
    test('document can be reset to default', () {
      tdoc.reset();
      expect(tdoc.downloadName, 'np8080.txt');
    });
  });
}
