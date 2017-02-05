import 'package:np8080/services/textprocessingservice.dart';
import 'package:test/test.dart';


void main() {
  TextProcessingService tps = new TextProcessingService();

  group('Core :', () {
    test('trim', () {
      expect(tps.trimText(" hello "), "hello");
    });

    test('getWordCount', () {
      expect(tps.getWordCount(" hello "), 1);
      expect(tps.getWordCount(" hello world. "), 2);
      expect(tps.getWordCount("Dart is Awesome and cool!"), 5);
      expect(tps.getWordCount("Count ALL the words!"), 4);
    });

    test('getLineCount', () {
      expect(tps.getLineCount(""), 0);
      expect(tps.getLineCount("hello"), 0);
      expect(tps.getLineCount("hello\n"), 1);
      expect(tps.getLineCount("hello\nthere\nare\napples\nin\nhere."), 5);
    });

    test('prefixLines',(){
      expect(tps.prefixLines("", "TEST"), "TEST");
      expect(tps.prefixLines("\n\n", "TEST"), "TEST\nTEST\nTEST");
      expect(tps.prefixLines("asdf\nxyzz\n", "  "), "  asdf\n  xyzz\n  ");
      expect(tps.prefixLines("Cup", ""), "Cup");
    });

    test('postfixLines',(){
      expect(tps.postfixLines("", "TEST"), "TEST");
      expect(tps.postfixLines("a\nb\n", "TEST"), "aTEST\nbTEST\nTEST");
      expect(tps.postfixLines("asdf\nxyzz\n", "12345"), "asdf12345\nxyzz12345\n12345");
      expect(tps.postfixLines("Coffee", "Cup"), "CoffeeCup");
    });
    test('doubleSpaceLines',(){
      expect(tps.doubleSpaceLines(""),"");
      expect(tps.doubleSpaceLines("Moo\n"),"Moo\n\n");
      expect(tps.doubleSpaceLines("Moo\nBaa"),"Moo\n\nBaa");
      expect(tps.doubleSpaceLines("Moo\nBaa\n"),"Moo\n\nBaa\n\n");
      expect(tps.doubleSpaceLines("Moo\n\nBaa\n"),"Moo\n\n\n\nBaa\n\n");
    });

    test('removeBlankLines', () {
      expect(tps.removeBlankLines(""), "");
      expect(tps.removeBlankLines("\n\n\n\n\nhello"), "hello");
      expect(tps.removeBlankLines("hello\n\n\n"), "hello\n");
      expect(tps.removeBlankLines("hello\nthere\nare\napples\nin\nhere.\n"),
          "hello\nthere\nare\napples\nin\nhere.\n");
      expect(
          tps.removeBlankLines("hello\nthere\nare\napples\n\n\n\nin\nhere.\n"),
          "hello\nthere\nare\napples\nin\nhere.\n");
    });

    test('removeExtraBlankLines', () {
      expect(tps.removeExtraBlankLines(""), "");
      expect(tps.removeExtraBlankLines("\n\n\n\n\nhello"), "\n\nhello");
      expect(tps.removeExtraBlankLines("hello\n\n\n"), "hello\n\n");
      expect(tps.removeExtraBlankLines("hello\n\n\nthere\n"), "hello\n\nthere\n");
    });

    test('getRepeatedString', () {
      expect(tps.getRepeatedString("Moo", 4), "MooMooMooMoo");
      expect(tps.getRepeatedString("Moo", 0), "");
    });

    test('convertMarkdownToHtml', () {
      expect(tps.convertMarkdownToHtml("# Moo"), "<h1>Moo</h1>\n");
    });

    test('sort - single line', () {
      expect(tps.sort("Dogs are the best!"), "Dogs are best! the");
    });

    test('sort - multi lines', () {
      expect(
          tps.sort("Zebras are cool!\nMonkeys are okay!\nDogs are the best!"),
          "Dogs are the best!\nMonkeys are okay!\nZebras are cool!");
    });

    test('reverse - single line', () {
      expect(tps.reverse("Dogs are the best!"), "best! the are Dogs");
    });

    test('reverse - multi line', () {
      expect(tps.reverse(
          "Zebras are cool!\nMonkeys are okay!\nDogs are the best!\n"),
          "Dogs are the best!\nMonkeys are okay!\nZebras are cool!");
    });

    test('replace', () {
      expect(tps.getReplaced("The cat sat on the mat", "cat", "dog"),
          "The dog sat on the mat");
    });
  });
}