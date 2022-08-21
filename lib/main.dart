import 'package:flutter/material.dart';

import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:provider/provider.dart';

import 'models/home_vo/home_vo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<HomeVo>(create: (_) => HomeVo()),
        ],
        child: MaterialApp(
          title: '帕比-寵物交友',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => LoginPage(),
            '/home': (context) => HomePage(),
          },
        ));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: <Widget>[Text('HomePage')]));
  }
}

class LoginPage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<LoginPage> {
  late VlcPlayerController _videoPlayerController;
  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
    await _videoPlayerController.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //    bool? logined = Provider.of<HomeVo>(context, listen: false).logined;
  //   if (logined ?? false) {
  //     Navigator.pushReplacementNamed(context, '/home');
  //     return;
  //   }
  // }
  @override
  void initState() {
    super.initState();
    loadVideoPlayer();
    setState() {}
    ;
  }

  loadVideoPlayer() {
    _videoPlayerController = VlcPlayerController.asset(
      'assets/loginScreen.mp4',
      hwAcc: HwAcc.full,
      autoPlay: true,
      autoInitialize: true,
      options: VlcPlayerOptions(),
    );
    _videoPlayerController.addListener(() {

      if (_videoPlayerController.value.playingState == PlayingState.ended) {

        _videoPlayerController.stop().then((_) => _videoPlayerController.play());

      }

    });
    // _videoPlayerController.initialize().then((value) {
    //   _videoPlayerController.play();
    //   _videoPlayerController.setLooping(true);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
            Positioned(
                child:  VlcPlayer(
            controller: _videoPlayerController,
            aspectRatio: 16 / 9,
            placeholder: Center(child: CircularProgressIndicator()),
          )
            )
         
        ]),
      ),
    );
  }
}
