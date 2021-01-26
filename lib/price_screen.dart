import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'coin_Rate.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String originalCurrency1 = 'BTC';
  String originalCurrency2 = 'ETH';
  String originalCurrency3 = 'LTC';
  String selectedCurrency = 'USD';
  String bitCoinExchangeRate1 = '?' ;
  String bitCoinExchangeRate2 = '?' ;
  String bitCoinExchangeRate3 = '?' ;

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(item);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData1();
          getData2();
          getData3();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      var item = Text(
        currency,
        style: TextStyle(color: Colors.white),
      );
      pickerItems.add(item);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedItems) {
        setState(() {
          selectedCurrency = currenciesList[selectedItems];
          print(currenciesList[selectedItems]);
          getData1();
          getData2();
          getData3();
        });
      },
      children: pickerItems,
    );
  }
  void getData1() async{
    try {
      double data = await coinRateTransfer(coinFrom: originalCurrency1,coinTo: selectedCurrency).getcoinRate();
      setState(() {
        bitCoinExchangeRate1 = data.toStringAsFixed(0);
      });
    }
    catch(e){
      print(e);
    }
  }void getData2() async{
    try {
      double data = await coinRateTransfer(coinFrom: originalCurrency2,coinTo: selectedCurrency).getcoinRate();
      setState(() {
        bitCoinExchangeRate2 = data.toStringAsFixed(0);
      });
    }
    catch(e){
      print(e);
    }
  }
  void getData3() async{
    try {
      double data = await coinRateTransfer(coinFrom: originalCurrency3,coinTo: selectedCurrency).getcoinRate();
      setState(() {
        bitCoinExchangeRate3 = data.toStringAsFixed(0);
      });
    }
    catch(e){
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    getData1();
    getData2();
    getData3();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('🤑 Coin Ticker'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              bodyCard(originalCurrency: originalCurrency1, bitCoinExchangeRate: bitCoinExchangeRate1, selectedCurrency: selectedCurrency),
              bodyCard(originalCurrency: originalCurrency2, bitCoinExchangeRate: bitCoinExchangeRate2, selectedCurrency: selectedCurrency),
              bodyCard(originalCurrency: originalCurrency3, bitCoinExchangeRate: bitCoinExchangeRate3, selectedCurrency: selectedCurrency),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}

class bodyCard extends StatelessWidget {
  const bodyCard({
    Key key,
    @required this.originalCurrency,
    @required this.bitCoinExchangeRate,
    @required this.selectedCurrency,
  }) : super(key: key);

  final String originalCurrency;
  final String bitCoinExchangeRate;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $originalCurrency = $bitCoinExchangeRate $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
