import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/net/api_methods.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'add_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;
  double binanceCoin = 0.0;
  double usdCoin = 0.0;
  double cardano = 0.0;
  double solana = 0.0;
  double terra = 0.0;
  double dogecoin = 0.0;
  double polkadot = 0.0;
  double avalanche = 0.0;

  @override
  // ignore: must_call_super
  void initState() {
    getValue();
  }

  getValue() async {
    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    tether = await getPrice("tether");
    binanceCoin = await getPrice("binance coin");
    usdCoin = await getPrice("usd coin ");
    cardano = await getPrice("cardano");
    solana = await getPrice("solana");
    terra = await getPrice("terra");
    dogecoin = await getPrice("dogecoin");
    polkadot = await getPrice("polkadot");
    avalanche = await getPrice("avalanche");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_element
    getValue(String id, double amount) {
      if (id == "bitcoin") {
        return bitcoin * amount;
      } else if (id == "ethereum") {
        return ethereum * amount;
      } else if (id == "tether") {
        return tether * amount;
      } else if (id == "binance coin") {
        return binanceCoin * amount;
      } else if (id == "usd coin") {
        return usdCoin * amount;
      } else if (id == "cardano") {
        return cardano * amount;
      } else if (id == "solana") {
        return solana * amount;
      } else if (id == "terra") {
        return terra * amount;
      } else if (id == "dogecoin") {
        return dogecoin * amount;
      } else if (id == "polkadot") {
        return polkadot * amount;
      } else if (id == "avalanche") {
        return avalanche * amount;
      }
    }

    return Scaffold(
      drawer: Drawer(
        child: ListView(children: [],),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "COLLECTION",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection('Coins')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, left: 15.0, right: 15.0),
                      child: Container(
                          height: MediaQuery.of(context).size.height / 12,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "Coin: ${document.id}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Rs.${getValue(document.id, document['Amount'])!.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  await removeCoin(document.id);
                                },
                              ),
                            ],
                          )),
                    );
                  }).toList(),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddView()),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
