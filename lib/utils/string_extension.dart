import 'dart:math';

extension XString on String {
  String shuffleString() {
    // Convert the string to a list of characters
    List<String> characters = split('');

    // Shuffle the list
    characters.shuffle(Random());
    // Convert the list back to a string and return
    return characters.reduce((last, curr) => '$last$curr');
  }

  String replaceAsset() {
    return replaceAll("assets/images/", "");
  }

  String withAssetPath() {
    return "assets/images/$this";
  }
}
