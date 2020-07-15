import 'dart:async';
import 'QRscan.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'constants.dart' show APP_DESCRIPTION, kAppIcon;


class HomePage extends StatefulWidget {

  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 2;
  String qrCodeResult = "Not Yet Scanned";
  /*@override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (!snapshot.hasData) {
          return _MySplashScreen();
        }
        return ChangeNotifierProvider<MyAppSettings>.value(
          value: MyAppSettings(snapshot.data),
          child: _MyMainApp(),
        );
      },
    );
  }*/
  final List<String> entries = <String>[APP_DESCRIPTION, 'Source code on GitHub', 'Visit my website'];
  final List<int> colorCodes = <int>[60, 50, 20];

  PageController _pageController = PageController(initialPage: 2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() =>
              currentIndex = index
            );
          },
          children: <Widget>[
            Container(
              color: Colors.deepPurpleAccent,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Result",
                    style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    qrCodeResult,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  FlatButton(
                    padding: EdgeInsets.all(15.0),
                    onPressed: () async {
                      String codescanner = await scanner.scan();    //barcode scnner
                      setState(() {
                        qrCodeResult = codescanner;
                      });
                    },
                      child: Text(
                        "Open Scanner",
                        style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white54, width: 1.5),
                          borderRadius: BorderRadius.circular(25.0)),
                    )
                  ],
                ),
                /*FlatButton(
              padding: EdgeInsets.all(15.0),
              onPressed: () async {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => widget));
              },
              child: Text(
                text,
                style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.red,width: 3.0),
                  borderRadius: BorderRadius.circular(40.0)),*/
                /*FlatButton(
                  padding: EdgeInsets.all(15.0),
                  onPressed: () async {
                    String codescanner = await scanner.scan();    //barcode scnner
                    setState(() {
                      qrCodeResult = codescanner;
                    });

                    // try{
                    //   BarcodeScanner.scan()    this method is used to scan the QR code
                    // }catch (e){
                    //   BarcodeScanner.CameraAccessDenied;   we can print that user has denied for the permisions
                    //   BarcodeScanner.UserCanceled;   we can print on the page that user has cancelled
                    // }


                  },
                  child: Text(
                    "Open Scanner",
                    style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue, width: 3.0),
                      borderRadius: BorderRadius.circular(20.0)),
                );*/
              ),
            /*new GestureDetector(
                onTap: _scanQR
            ),*/
            Container(color: Colors.lightBlueAccent,),
            Container(color: Colors.purpleAccent,),
            //Container(color: Colors.pinkAccent,),
            Container(
                color: Colors.pinkAccent,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        color: Colors.pinkAccent,
                        child: Center(child: Text('${entries[index]}',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),),
                      );
                    },
                ),
            ),
            Container(color: Colors.greenAccent,),
          ],
        ),
      ),


      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.ease,
        // jump page
        onItemSelected: (index) {
          setState(() => currentIndex = index);
          _pageController.jumpToPage(index);
        },
        // scroll page
        /*onItemSelected: (index) => setState(() {
          currentIndex = index;
          _pageController.animateToPage(currentIndex,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        }),*/
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.scanner),
            title: Text('QR Scanner'),
            activeColor: Colors.deepPurpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.kitchen),
            title: Text('Items'),
            activeColor: Colors.lightBlueAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.inbox),
            title: Text('Inbox'),
            activeColor: Colors.pinkAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.greenAccent,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  /*Widget flatButton() {
    String qrCodeResult = "Not Yet Scanned";
    Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Result",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            qrCodeResult,
            style: TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.0,
          ),
          FlatButton(
            padding: EdgeInsets.all(15.0),
            onPressed: () async {
              String codescanner = await scanner.scan();    //barcode scnner
              setState(() {
                qrCodeResult = codescanner;
              });

              // try{
              //   BarcodeScanner.scan()    this method is used to scan the QR code
              // }catch (e){
              //   BarcodeScanner.CameraAccessDenied;   we can print that user has denied for the permisions
              //   BarcodeScanner.UserCanceled;   we can print on the page that user has cancelled
              // }


            },
            child: Text(
              "Open Scanner",
              style:
              TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17),
            ),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue, width: 3.0),
                borderRadius: BorderRadius.circular(20.0)),
          )
        ],
      ),
     /*FlatButton(
      padding: EdgeInsets.all(15.0),
      onPressed: () async {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
      },
      child: Text(
        text,
        style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.red,width: 3.0),
          borderRadius: BorderRadius.circular(40.0)),*/
        FlatButton(
          padding: EdgeInsets.all(15.0),
          onPressed: () async {
            String codescanner = await scanner.scan();    //barcode scnner
            setState(() {
              qrCodeResult = codescanner;
            });

            // try{
            //   BarcodeScanner.scan()    this method is used to scan the QR code
            // }catch (e){
            //   BarcodeScanner.CameraAccessDenied;   we can print that user has denied for the permisions
            //   BarcodeScanner.UserCanceled;   we can print on the page that user has cancelled
            // }


          },
          child: Text(
            "Open Scanner",
            style:
            TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.blue, width: 3.0),
              borderRadius: BorderRadius.circular(20.0)),
        );
    );
  }*/
}


