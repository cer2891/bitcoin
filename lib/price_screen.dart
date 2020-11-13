import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectCurent = 'RUB';
  var bitconRub='?';

  DropdownButton<String> getAndroidDownButton() {

    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currently in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currently),
        value: currently,
      );

      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectCurent,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectCurent = value;
        });
      },
    );
  }


  CupertinoPicker iOSPicker() {
    List<Widget> Item = [];
    for (String currently in currenciesList) {
      Item.add(Text(currently));
    }

    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(currenciesList[selectedIndex]);
        selectCurent=currenciesList[selectedIndex];
        getData();
      },
      children: Item,
    );
  }

  Widget getPicker(){
    if(Platform.isIOS){
      return iOSPicker();
    }
    else if (Platform.isAndroid){
      return getAndroidDownButton();
    }
  }

  void getData() async{
    try{
      var data=await CoinData().getCoinData(selectCurent);
      setState(() {
        bitconRub=data.toStringAsFixed(0);
      });
    }catch(e){
      print(e);
    }
  }

  @override
  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
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
                  '1 BTC = $bitconRub $selectCurent',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.black,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitconRub $selectCurent',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isAndroid ? iOSPicker() : getAndroidDownButton(),//getAndroidDownButton(),
          ),
        ],
      ),
    );
  }
}

// DropdownButton<String>(
// value: selectCurent,
// items: getDropdownItems(),
// onChanged: (value){
// setState(() {
// selectCurent=value;
// });
// }),
