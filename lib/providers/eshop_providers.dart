import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ValueNotifier<int> bannerIndexNotifier = ValueNotifier<int>(0);
final termsProvdier = StateProvider<bool>((ref) {
  return false;
});

class EshopProvider extends ChangeNotifier {}
