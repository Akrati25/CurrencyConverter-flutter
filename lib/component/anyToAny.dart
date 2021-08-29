import 'package:flutter/cupertino.dart';
import 'package:myfirstapp/function/fetchrates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnyToAny extends StatefulWidget {
  final rates;
  final Map currencies;

  const AnyToAny({Key? key, @required this.rates, required this.currencies})
      : super(key: key);

  @override
  _AnyToAnyState createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {
  TextEditingController amountController = TextEditingController();

  String dropdownValue1 = 'USD';
  String dropdownValue2 = 'EUR';
  String answer = '';
  String input = 'Enter here';

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[

        //First card
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 12,
          child: Container(
            width: 200,
            margin: EdgeInsets.symmetric(horizontal: 200),
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,
                width: 20,),
                Row(children: [
                  Expanded(
                    child: DropdownButton<String>(

                      value: dropdownValue1,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 24,
                      elevation: 16,
                      // isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue1 = newValue!;
                        });
                      },
                      items: widget.currencies.keys
                          .toSet()
                          .toList()
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ]),
                SizedBox(height: 10),
                TextFormField(
                  key: ValueKey('amount'),
                  controller: amountController,
                  decoration: InputDecoration(hintText: 'Enter Amount',
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade400
                  )),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),

         Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    answer =
                        convertany(widget.rates, amountController.text,
                            dropdownValue1, dropdownValue2)
                            ;
                  });
                },
                child: Text('Convert', style: TextStyle(fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
              ),
            ),
            SizedBox(width: 20),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    String originalCurrency = dropdownValue1;

                    dropdownValue1 = dropdownValue2;
                    dropdownValue2 = originalCurrency;
                    amountController.text = answer;
                    answer =
                        convertany(widget.rates, amountController.text,
                            dropdownValue1, dropdownValue2);
                  });
                },
                child: Text('Swap', style: TextStyle(fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),

              ),
            ),
          ],
          ),
        SizedBox(height: 20),

        //Second Card
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 12,
          child: Container(
            width: 200,
            height: 160,
            margin: EdgeInsets.symmetric(horizontal: 200),
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: dropdownValue2,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 24,
                      elevation: 16,
                      // isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue2 = newValue!;
                          answer =
                              convertany(widget.rates, amountController.text,
                                  dropdownValue1, dropdownValue2);
                        });
                      },
                      items: widget.currencies.keys
                          .toSet()
                          .toList()
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ]),
                SizedBox(height: 10),
                Container(
                    color: Colors.white,
                    child: Text(answer, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
