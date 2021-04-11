import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const defaultBillingAmount = 0.0;
  static const defaultPercentAmount = 15;
  final billingAmountController =
      TextEditingController(text: defaultBillingAmount.toString());
  final percentAmountController =
      TextEditingController(text: defaultPercentAmount.toString());
  double billingAmount = defaultBillingAmount;
  int percentAmount = defaultPercentAmount;
  @override
  void initState() {
    super.initState();
    billingAmountController.addListener(_onBillingAmountChange);
    percentAmountController.addListener(_onPercentAmountChange);
  }

  _onBillingAmountChange() {
    setState(() {
      billingAmount = double.tryParse(billingAmountController.text) ?? 0;
    });
  }

  _onPercentAmountChange() {
    setState(() {
      percentAmount = int.tryParse(percentAmountController.text) ?? 0;
    });
  }

  _getTipsAmount() => billingAmount * percentAmount / 100;
  _getTotall() => billingAmount + _getTipsAmount();
  _reset() {
    billingAmountController.clear();
    percentAmountController.clear();
    setState(() {});
  }

  @override
  void dispose() {
    billingAmountController.dispose();
    percentAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Demo Tip`s Calculator'.toUpperCase(),
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  key: Key('amountController'),
                  controller: billingAmountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                      hintText: 'Enter Bill Amount',
                      labelText: 'Bill Amount',
                      labelStyle: TextStyle(
                        fontSize: 25,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0))),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  key: Key('percentAmount'),
                  controller: percentAmountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: 'Enter Percent Amount',
                    labelText: 'Percent Amount',
                    labelStyle: TextStyle(
                      fontSize: 25,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(color: Colors.black26),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(2, 2),
                          spreadRadius: 2,
                          blurRadius: 1,
                        ),
                      ]),
                  child: Column(
                    children: [
                      AmountText('Tips Amount: ${_getTipsAmount()}'),
                      AmountText('Tottal : ${_getTotall()}')
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FlatButton.icon(
                  onPressed: _reset,
                  icon: Icon(
                    Icons.delete,
                    size: 40,
                    color: Colors.red,
                  ),
                  label: Text('Reset'),
                  highlightColor: Colors.black26,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AmountText extends StatelessWidget {
  final String text;
  const AmountText(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9.0),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
