import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = [
    "bitcoin",
    "tether",
    "ethereum",
    "binance coin",
    "usd coin",
    "cardano",
    "solana",
    "terra",
    "dogecoin",
    "polkadot",
    "avalanche"
  ];
  String dropdownValue = "bitcoin";
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("ADD COIN", style: TextStyle(fontSize: 24),),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: DropdownButton(
              value: dropdownValue,
              onChanged: (value) {
                setState(() {
                  dropdownValue = value.toString();
                });
              },
              items: coins.map<DropdownMenuItem<String>>(( String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Center(
                child: TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    labelText: "Coin Amount",
                    ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    await addCoin(dropdownValue, amountController.text);
                   Navigator.of(context).pop(); 
                  }, 
                  child: const Text("Add"),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
