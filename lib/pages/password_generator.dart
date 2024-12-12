import 'dart:math';

String randomPasswordGenerator({
  required int length,
  required bool includeUpperCase,
  required bool includeLowerCase,
  required bool includeNumbers,
  required bool includeSpecialCharacters,
}) {
  const String upperCaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWWXYZ';
  const String lowerCaseLetters = 'abcdefghijklmnopqrstuvwxyz';
  const String numbers = '0123456789';
  const String specialCharacters = '!@#\$%^&*()-_=+<>?';

  String characters = '';

  if (includeUpperCase) characters += upperCaseLetters;
  if (includeLowerCase) characters += lowerCaseLetters;
  if (includeNumbers) characters += numbers;
  if (includeSpecialCharacters) characters += specialCharacters;

  if (characters.isEmpty) {
    throw Exception('No character types selected');
  }

  Random random = Random();
  return List.generate(
      length, (index) => characters[random.nextInt(characters.length)]).join();
}
