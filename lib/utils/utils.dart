import 'dart:convert';
import 'dart:math';

class Utils {
  static String uniqueRefenece([int length = 32]) {
    final Random random = Random.secure();
    var values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }
}