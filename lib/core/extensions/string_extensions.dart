import 'dart:convert' as convert;
const utf8Codec = convert.utf8;

/// String extensions for common operations
extension StringExtensions on String {
  /// Check if string is email
  bool get isEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Check if string is valid URL
  bool get isUrl {
    final urlRegex = RegExp(
      r'^(https?|ftp)://[^\s/$.?#].[^\s]*$',
      caseSensitive: false,
    );
    return urlRegex.hasMatch(this);
  }

  /// Check if string is phone number (basic)
  bool get isPhoneNumber {
    final phoneRegex = RegExp(r'^[0-9]{10,15}$');
    return phoneRegex.hasMatch(replaceAll(RegExp(r'\D'), ''));
  }

  /// Check if string is valid password (min 8 chars, uppercase, lowercase, number)
  bool get isValidPassword {
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$',
    );
    return passwordRegex.hasMatch(this);
  }

  /// Capitalize first letter
  String get capitalize {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  /// Title case (capitalize each word)
  String get toTitleCase {
    return split(' ')
        .map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  /// Remove all whitespace
  String get removeWhitespace {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Reverse string
  String get reverse {
    return split('').reversed.join('');
  }

  /// Check if string is numeric
  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  /// Check if string is integer
  bool get isInteger {
    return int.tryParse(this) != null;
  }

  /// Get initials from name
  String get getInitials {
    final parts = trim().split(RegExp(r'\s+'));
    final initials = parts
        .take(2)
        .map((part) => part.isNotEmpty ? part[0].toUpperCase() : '')
        .join();
    return initials.isEmpty ? '?' : initials;
  }

  /// Truncate string with ellipsis
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return substring(0, maxLength - ellipsis.length) + ellipsis;
  }

  /// Mask email (example@email.com -> ex***@email.com)
  String get maskEmail {
    if (!isEmail || length < 5) return this;
    final parts = split('@');
    final name = parts[0];
    final domain = parts[1];
    final maskedName = name[0] + ('*' * (name.length - 2)) + name[name.length - 1];
    return '$maskedName@$domain';
  }

  /// Mask phone number (1234567890 -> 123****890)
  String get maskPhone {
    final cleaned = replaceAll(RegExp(r'\D'), '');
    if (cleaned.length < 6) return this;
    final start = cleaned.substring(0, 3);
    final end = cleaned.substring(cleaned.length - 3);
    final mask = '*' * (cleaned.length - 6);
    return '$start$mask$end';
  }

  /// Convert to slug (for URLs)
  String get toSlug {
    return toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
  }

  /// Check if string is palindrome
  bool get isPalindrome {
    final cleaned = removeWhitespace.toLowerCase();
    return cleaned == cleaned.reverse;
  }

  /// Count word occurrences
  int countWord(String word) {
    return RegExp(r'\b' + RegExp.escape(word) + r'\b', caseSensitive: false).allMatches(this).length;
  }

  /// Replace multiple patterns
  String replaceMultiple(Map<String, String> replacements) {
    String result = this;
    replacements.forEach((key, value) {
      result = result.replaceAll(key, value);
    });
    return result;
  }

  /// Check if string contains emoji
  bool get hasEmoji {
    final emojiRegex = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|[\ud83c\ud83d\ud83e][\udc00-\udef8]|\ud83d[\udc00-\udefd])',
    );
    return emojiRegex.hasMatch(this);
  }

  /// Remove emoji
  String get removeEmoji {
    return replaceAll(
      RegExp(
        r'(\u00a9|\u00ae|[\u2000-\u3300]|[\ud83c\ud83d\ud83e][\udc00-\udef8]|\ud83d[\udc00-\udefd])',
      ),
      '',
    );
  }

  /// Convert to camelCase
  String get toCamelCase {
    final parts = split(RegExp(r'\s+'));
    if (parts.isEmpty) return this;
    final first = parts[0].toLowerCase();
    final rest = parts.skip(1).map((part) => part.capitalize).join();
    return first + rest;
  }

  /// Convert to snake_case
  String get toSnakeCase {
    return replaceAll(RegExp(r'(?<=[a-z])(?=[A-Z])'), '_').toLowerCase();
  }

  /// Get byte size
  int get byteLength {
    return utf8Codec.encode(this).length;
  }

  /// Check if empty or whitespace only
  bool get isNullOrEmpty {
    return isEmpty || trim().isEmpty;
  }
}



