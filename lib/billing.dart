import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'dart:io';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => new _PaymentState();
}

class _PaymentState extends State<Payment> {
  Token _paymentToken;
  PaymentMethod _paymentMethod;
  String _error;
  final String _currentSecret =
      "sk_test_XcdFPX77RbWdtgNtPg4n5Ror00tc9bYjcq"; //set this yourself, e.g using curl
  PaymentIntentResult _paymentIntent;
  Source _source;

  ScrollController _controller = ScrollController();

  final CreditCard testCard = CreditCard(
    number: '4111111111111111',
    expMonth: 08,
    expYear: 22,
  );

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  initState() {
    super.initState();

    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_AdUxvKKTKzgyJlrhAWlsagaG00ahDF3DX6",
        merchantId: "Test",
        androidPayMode: 'test'));
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(
          'Payment',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _source = null;
                _paymentIntent = null;
                _paymentMethod = null;
                _paymentToken = null;
              });
            },
          )
        ],
      ),
      body: ListView(
        controller: _controller,
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Divider(),
          SizedBox(
            height: 140,
          ),
          RaisedButton(
            child: Text("Create Token with Card Form"),
            onPressed: () {
              StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
                  .then((paymentMethod) {
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text('Received ${paymentMethod.id}')));
                setState(() {
                  _paymentMethod = paymentMethod;
                });
              }).catchError(setError);
            },
          ),
          //Divider(),
          RaisedButton(
            child: Text("Native payment"),
            onPressed: () {
              if (Platform.isIOS) {
                _controller.jumpTo(450);
              }
              StripePayment.paymentRequestWithNativePay(
                androidPayOptions: AndroidPayPaymentRequest(
                  totalPrice: "2.40",
                  currencyCode: "EUR",
                ),
                applePayOptions: ApplePayPaymentOptions(
                  countryCode: 'DE',
                  currencyCode: 'EUR',
                  items: [
                    ApplePayItem(
                      label: 'Test',
                      amount: '27',
                    )
                  ],
                ),
              ).then((token) {
                setState(() {
                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text('Received ${token.tokenId}')));
                  _paymentToken = token;
                });
              }).catchError(setError);
            },
          ),
          RaisedButton(
            child: Text("Complete Native Payment"),
            onPressed: () {
              StripePayment.completeNativePayRequest().then((_) {
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text('Completed successfully')));
              }).catchError(setError);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
