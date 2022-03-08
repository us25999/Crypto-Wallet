import 'package:crypto_wallet/net/api_methods.dart';
import 'package:crypto_wallet/ui/authentication.dart';
import 'package:crypto_wallet/ui/home_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Wallet',
      home: FutureBuilder(
        future: getCurrentUser(),
        builder:(context,snapshot){
        return snapshot.hasData?HomeView():Authentication();
      }),
      debugShowCheckedModeBanner: false,
    );
  }
}


