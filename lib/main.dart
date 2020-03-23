import 'package:app_tcc/utils/Preferencias.dart';
import 'package:app_tcc/view/HomePage.dart';
import 'package:app_tcc/view/IntroducaoPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash()
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Preferencias preferencias = Preferencias();

  Future getPlatform()async{
    var intro = await preferencias.getIntro();

    if(intro == false){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => IntrotucaoPage()));
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPlatform(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(),);
            case ConnectionState.active:
            case ConnectionState.done:
          }
          return Center(
            child: CircleAvatar(maxRadius: 100, backgroundColor: Colors.white,),
          );
        },
      ),
    );
  }
}

