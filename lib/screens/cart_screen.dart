import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:intl/intl.dart';
import 'package:safetiedassignment/screens/check_out_screen.dart';

//providers
import '../providers/products_provider.dart';

//widgets
import '../widgets/product_item.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "cart-screen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void submitValue(String barcodeValue) {
    Provider.of<ProductsProvider>(context, listen: false).fetchProducts(
      barcodeValue.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MY CART"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(8, 3, 8, 60),
        child: Consumer<ProductsProvider>(builder: (context, productsData, _) {
//          return Container();
          return productsData.products.length == 0
              ? Container(
                  child: Center(
                    child: Text("No products in cart"),
                  ),
                )

              /// I used this approach instead of list view builder because
              /// if the list is long enough and you scroll to the end then the
              /// last element is not completely visible because of the
              /// bottom sheet and FAB
              : SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: productsData.products.map<Widget>((product) {
                          return ProductItem(product);
                        }).toList(),
                      ),

                      // This is for visibility
                      productsData.products.length < 5
                          ? Container()
                          : SizedBox(
                              height: 100,
                            ),
                    ],
                  ),
                );
//              : ListView.builder(
//                  itemBuilder: (ctx, index) {
//                    return ProductItem(productsData.products[index]);
//                  },
//                  itemCount: productsData.products.length,
//                );
        }),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        child: Consumer<ProductsProvider>(builder: (context, productsData, _) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "TOTAL\n",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text:
                          "${NumberFormat.simpleCurrency(locale: "en_IN").format(productsData.totalPrice)}",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CheckOutScreen.routeName);
                },
                child: Text(
                  "CHECKOUT",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Theme.of(context).accentColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
        child: FloatingActionButton(
          elevation: 4,
          onPressed: () async {
            var result = await BarcodeScanner.scan();
            submitValue(result.rawContent.toString());
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
