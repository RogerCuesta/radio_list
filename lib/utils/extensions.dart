extension StringExtension on String {
  String capitalize() {
    if (this != '') {
      return '${this[0].toUpperCase()}${substring(1)}';
    } else {
      return '';
    }
  }

  String unescape() {
    return replaceAll('&amp;', '&')
        .replaceAll('&#039;', "'")
        .replaceAll('&quot;', '"')
        .trim();
  }

  String capitalizeWordsSeparatedByCommas() {
    List<String> words = split(',');

    List<String> capitalizedWords = words.map((word) {
      return word.trim().capitalize();
    }).toList();

    return capitalizedWords.join(', ');
  }
}
