import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', ''), // Farsi, no country code
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'vazir',
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
          )),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Currency> currency = [];

  Future _getResponse(BuildContext context) async {
    var url = "http://sasansafari.com/flutter/api.php?access_key=flutter123456";
    var value = await http.get(Uri.parse(url));
    print(value.statusCode);
    if (currency.isEmpty) {
      if (value.statusCode == 200) {
        showSnackBAr(context, 'بروز رسانی با موفقیت انجام شد');
        List jsonList = convert.jsonDecode(value.body);
        if (jsonList.length > 0) {
          setState(() {
            for (int i = 0; i < jsonList.length; i++) {
              currency.add(Currency(
                  id: jsonList[i]["id"],
                  title: jsonList[i]["title"],
                  price: jsonList[i]["price"],
                  changes: jsonList[i]["changes"],
                  status: jsonList[i]["status"]));
            }
          });
        }
      }
    }
    return value;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getResponse(context);
  }

  @override
  Widget build(BuildContext context) {
    // _getResponse();
    // currency.add(Currency(
    //     id: "1", title: "دلار", price: "27000", changes: "3+", status: "p"));
    // currency.add(Currency(
    //     id: "1",
    //     title: "دلار استرالیا",
    //     price: "27000",
    //     changes: "3+",
    //     status: "p"));
    // currency.add(Currency(
    //     id: "1", title: "یورو", price: "27000", changes: "3+", status: " n"));
    // currency.add(Currency(
    //     id: "1", title: "دلار", price: "27000", changes: "3+", status: "p"));
    // currency.add(Currency(
    //     id: "1", title: "دلار", price: "27000", changes: "3+", status: "n"));
    // currency.add(Currency(
    //     id: "1", title: "دلار", price: "27000", changes: "3+", status: "p"));
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Image.asset("assets/images/icon.png"),
          const Align(
            alignment: Alignment.center,
            child: Text("قیمت به روز ارز",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
          ),
          Expanded(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset('assets/images/menu.png'))),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/images/img.png'),
                const SizedBox(
                  width: 8,
                ),
                const Text("نرخ ازاد ارز چیست؟",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Text(
                  " نرخ ارزها در معاملات نقدی و رایج روزانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله، ارز و ریال را با هم تبادل می نمایند. ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w300)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Container(
                width: double.infinity,
                height: 35,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 132, 132, 132),
                    borderRadius: BorderRadius.circular(1000)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text('نام آزاد ارز',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300)),
                    Text("قیمت",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300)),
                    Text('وضعیت',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
              child: Container(
                  width: double.infinity,
                  height: 350,

                  ///ListView
                  child: ListFuter(context)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: const Color.fromARGB(255, 232, 232, 232),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      //TextButton
                      child: TextButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 203, 195, 255)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(1000)))),
                          onPressed: () {
                            currency.clear();
                            ListFuter(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.refresh_bold,
                            color: Colors.black,
                          ),
                          label: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text('بروز رسانی',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                          )),
                    ),
                    Text("${_getTime()}"),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<dynamic> ListFuter(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.separated(
                itemCount: currency.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext cotext, int position) {
                  return MyItem(position, currency);
                },
                separatorBuilder: (BuildContext context, int index) {
                  if (index % 9 == 0) {
                    return const Add();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
      future: _getResponse(context),
    );
  }

  _getTime() {
    DateTime now = DateTime.now();


    return  DateFormat('kk:mm:ss').format(now);
  }
}

class MyItem extends StatelessWidget {
  int position;
  List<Currency> currency;

  MyItem(
    this.position,
    this.currency,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: const <BoxShadow>[
            BoxShadow(blurRadius: 1, color: Colors.grey)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(1000),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              currency[position].title!,
              style: const TextStyle(
                  fontFamily: 'vazir',
                  fontWeight: FontWeight.w300,
                  fontSize: 13),
            ),
            Text(
              currency[position].price!,
              style: const TextStyle(
                  fontFamily: 'vazir',
                  fontWeight: FontWeight.w300,
                  fontSize: 13),
            ),
            Text(
              currency[position].changes!,
              style: currency[position].status == "n"
                  ? const TextStyle(
                      color: Colors.red,
                      fontFamily: 'vazir',
                      fontSize: 13,
                      fontWeight: FontWeight.w300)
                  : const TextStyle(
                      color: Colors.green,
                      fontFamily: 'vazir',
                      fontSize: 13,
                      fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}

class Add extends StatelessWidget {
  const Add({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(9, 5, 0, 0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(boxShadow: const <BoxShadow>[
          BoxShadow(blurRadius: 1.0, color: Colors.grey)
        ], borderRadius: BorderRadius.circular(1000), color: Colors.red),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              "تبلیغات",
              style: TextStyle(
                  fontFamily: 'vazir',
                  fontSize: 13,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}

void showSnackBAr(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

String getFarsiNumber(String number) {
  const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  for (var element in en) {
    number = number.replaceAll(element, fa[en.indexOf(element)]);
  }
  return number;
}
