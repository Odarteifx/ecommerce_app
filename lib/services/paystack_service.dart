import 'dart:convert';
import 'package:ecommerce_app/models/paystack_models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants/paystack_const.dart';
import 'package:ecommerce_app/models/paystack_models/api_response.dart';
import '../models/paystack_models/paystack_auth_response.dart';
import 'api_service.dart';

class PaystackService {
  final _apiService = ApiService();

//Initialize transaction
  Future<PaystackAuthResponse> initializeTransaction({
    required String email,
    required double amount,
    String currency = 'GHS',
    required String reference,
    List<String> channels = const ['card', 'mobile_money'],
    Object? metadata,
  }) async {
    ApiResponse response;

    try {
      response = await _apiService.post(
          url: PaystackConst.intializeTransaction,
          data: jsonEncode({
            'email': email,
            'amount': amount,
            'currency': currency,
            'reference': reference,
            'channels': channels,
            'metadata': metadata
          }));

      if (response.statusCode == 200) {
        return PaystackAuthResponse.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        debugPrint(response.error.toString());
        throw Exception('Error: ${response.error}');
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Exception('Error: $e');
    }
  }

  //Verify transaction
  Future verifyTransaction(
      String reference,
      Function(Object) onSuccessfulTransaction,
      Function(Object) onFailedTransaction) async {
    ApiResponse response;

    try {
      response = await _apiService.get(
          url: PaystackConst.verifyTransaction(reference));
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        if (data['gateway_response'] == 'Successful') {
          onSuccessfulTransaction(data);
        } else {
          onFailedTransaction(data);
        }
      } else {
        //notify user of transaction error
        onFailedTransaction(
            {'message': 'Transaction failed', 'error': response.error});
        debugPrint(response.error.toString());
      }
    } on Exception catch (e) {
      onFailedTransaction(
          {'message': 'Transaction failed', 'error': e.toString()});
      throw Exception('Error: $e');
    }
  }

  //List of Transactions
  Future<List<Transaction>> listTransactions() async {
    ApiResponse response;
    try {
      response = await _apiService.get(url: PaystackConst.listTransactions);
      if (response.statusCode == 200) {
        final data = response.data as List;
        if (data.isEmpty) {
          return [];
        }
        return data
            .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
