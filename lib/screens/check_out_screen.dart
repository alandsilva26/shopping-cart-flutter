import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckOutScreen extends StatelessWidget {
  static const routeName = "check-out-screen";
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CHECK OUT"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                heightFactor: 2,
                child: Image(
                  image: AssetImage('assets/images/creditCard.png'),
                  width: MediaQuery.of(context).size.width * 0.5,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "CREDIT CARD DETAILS",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "CARD NUMBER",
                          hintText: "xxxx xxxx xxxx xxxx",
                          suffixIcon: Image(
                            image: AssetImage('assets/images/visaLogo.png'),
                            width: 20,
                            fit: BoxFit.cover,
                          ),
                        ),
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly,
                          new LengthLimitingTextInputFormatter(16),
                          new CardNumberInputFormatter(),
                        ],
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "CARD HOLDER NAME",
                          hintText: "Name on card",
                        ),
                        textCapitalization: TextCapitalization.words,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "EXPIRY DATE",
                                hintText: "mm/yy",
                              ),
                              inputFormatters: [
                                new MaskedTextInputFormatter(
                                  mask: "xx/xx",
                                  separator: "/",
                                ),
                              ],
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "CVV",
                                hintText: "xxx",
                              ),
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                new LengthLimitingTextInputFormatter(3),
                              ],
                              obscureText: true,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 50,
                        ),
                        child: RaisedButton(
                          child: Text(
                            "PAY SECURELY",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {},
                          color: Theme.of(context).accentColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reference - https://medium.com/flutter-community/validating-and-formatting-payment-card-text-fields-in-flutter-bebe12bc9c60
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

//Reference: https://medium.com/flutterpub/flutter-credit-card-text-formatter-1e259b28cfa3
class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    @required this.mask,
    @required this.separator,
  }) {
    assert(mask != null);
    assert(separator != null);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 0) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}
