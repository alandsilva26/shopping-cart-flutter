import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//providers
import './providers/products_provider.dart';

//screens
import './screens/cart_screen.dart';
import './screens/check_out_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ProductsProvider>(
      create: (_) => ProductsProvider(),
      child: BarcodeScanner(),
    ),
  );
}

class BarcodeScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Barcode Scanner",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Color.fromRGBO(140, 48, 234, 1),
        appBarTheme: AppBarTheme(
          color: Color.fromRGBO(140, 48, 234, 1),
        ),
        splashColor: Colors.red,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(132, 132, 132, 1),
          ),
          bodyText2: TextStyle(
            fontSize: 15,
            color: Color.fromRGBO(132, 132, 132, 1),
          ),
          headline6: TextStyle(),
          subtitle1: TextStyle(
            color: Color.fromRGBO(132, 132, 132, 1),
          ),
        ),
      ),
      initialRoute: CartScreen.routeName,
      routes: {
        CartScreen.routeName: (context) => CartScreen(),
        CheckOutScreen.routeName: (context) => CheckOutScreen(),
      },
    );
  }
}
