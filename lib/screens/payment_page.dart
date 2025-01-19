// ignore_for_file: use_build_context_synchronously
import 'package:ecommerce_app/models/paystack_models/paystack_auth_response.dart';
import 'package:ecommerce_app/services/paystack_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends ConsumerWidget {
  final String reference;
  final double amount;
  final String email;
  final String currency;
  final Object? metadata;
  final Object? channel;
  final Function(Object?) onSuccessfulTransaction;
  final Function(Object?) onFailedTransaction;
  const PaymentPage(
      {required this.reference,
      required this.amount,
      required this.email,
      required this.currency,
      this.metadata,
      this.channel,
      required this.onSuccessfulTransaction,
      required this.onFailedTransaction,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     if (email.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Payment'),
        ),
        body: Center(
          child: Text('Error: Email is required'),
        ),
      );
    }
    
    return FutureBuilder<PaystackAuthResponse>(
      future: PaystackService().initializeTransaction(
          email: email,
          amount: amount,
          reference: reference,
          metadata: metadata),
      builder: (context, snapshot) {
        // ignore: deprecated_member_use
        return WillPopScope(
            onWillPop: () async {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data!.authorizationUrl != null) {
                PaystackService()
                    .verifyTransaction(
                      snapshot.data!.reference!,
                      onSuccessfulTransaction,
                      onFailedTransaction,
                    )
                    .then((value) => Navigator.of(context).pop());
                return false;
              }
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text('Payment'),
                leading: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData &&
                        snapshot.data!.authorizationUrl != null) {
                      PaystackService()
                          .verifyTransaction(
                            snapshot.data!.reference!,
                            onSuccessfulTransaction,
                            onFailedTransaction,
                          )
                          .then((value) => Navigator.of(context).pop());
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
              body: snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData &&
                      snapshot.data!.authorizationUrl != null
                  ? WebView(
                      initialUrl: snapshot.data!.authorizationUrl!,
                      javascriptMode: JavascriptMode.unrestricted,
                    )
                  : snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text("Error: ${snapshot.error}"),
            ));
      },
    );
  }
}
