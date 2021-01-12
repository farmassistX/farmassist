class Strings {
  static String toTitleCase(String sentence) {
    String titleCaseVar = sentence
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');

    return titleCaseVar;
  }
}
