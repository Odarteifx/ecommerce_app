import 'package:flutter/material.dart';

class CurrencyConverterModel extends ChangeNotifier {
  double? amountInCents;
  double? convertedAmount;

  void setAmountInCents(double? amount) {
    amountInCents = amount;
    notifyListeners();
  }

  void setConvertedAmount(double? amount) {
    convertedAmount = amount;
    notifyListeners();
  }
}