import 'package:myfirstapp/component/anyToAny.dart';
import 'package:myfirstapp/function/fetchrates.dart';
import 'package:myfirstapp/models/ratesmodel.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

   @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  late Future<Ratesmodel> result;
  late Future<Map> allcurrencies;
  final formkey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    setState(() {
      result = fetchrates();
      allcurrencies = fetchcurrencies();
    });
  }

  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: Text('Currency Converter')),

        //Future Builder for Getting Exchange Rates
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 400, vertical: 50),
          alignment: Alignment.topCenter,
          height: h,
          width: w,
          child: SingleChildScrollView(

            child: Form(
              key: formkey,
              child: FutureBuilder<Ratesmodel>(
                future: result,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Center(
                    child: FutureBuilder<Map>(
                        future: allcurrencies,
                        builder: (context, currSnapshot) {
                          if (currSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnyToAny(
                                currencies: currSnapshot.data!,
                                rates: snapshot.data!.rates,
                              ),
                            ],
                          );
                        }),
                  );
                },
              ),
            ),
          ),
        ));
  }
}