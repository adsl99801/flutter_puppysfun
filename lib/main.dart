
import 'package:go_router/go_router.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'models/home_vo/home_vo.dart';
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';s

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // static FirebaseAnalyticsObserver observer =
  //     FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Analytics Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
          routes: {
            '/': (context) => LoginPage(),
            '/home': (context) => HomePage(),
          },
    );
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
  late VideoPlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;

  // late VlcPlayerController _videoPlayerController;
  @override
  void dispose() async {
    _controller.dispose();
    super.dispose();
    // await _videoPlayerController.stopRendererScanning();
    // await _videoPlayerController.dispose();
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
    loadVideoPlayer();
    super.initState();
  }

  loadVideoPlayer() {
    _controller = VideoPlayerController.asset(
      'assets/login.mp4',
    )..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });
    _controller.addListener(() {
      setState(() {});
    });

    // _videoPlayerController = VlcPlayerController.asset(
    //   'assets/IMG_0631.MOV',
    //   hwAcc: HwAcc.full,
    //   autoPlay: true,
    //   autoInitialize: true,
    //   options: VlcPlayerOptions(),
    // );
    // _videoPlayerController.addListener(() {
    //   if (_videoPlayerController.value.playingState == PlayingState.ended) {
    //     _videoPlayerController
    //         .stop()
    //         .then((_) => _videoPlayerController.play());
    //   }
    // });
    // _videoPlayerController.initialize().then((value) {
    //   _videoPlayerController.play();
    //   _videoPlayerController.setLooping(true);
    // });
  }

  @override
  Widget build(BuildContext context) {
    var pd30 = (MediaQuery.of(context).size.height * 0.1);
    return Scaffold(
        body: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Stack(alignment: AlignmentDirectional.center, children: [
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: VideoPlayer(_controller)
                      // child: VlcPlayer(
                      //   controller: _videoPlayerController,
                      //   aspectRatio: 16 / 9,
                      //   placeholder:
                      //       const Center(child: CircularProgressIndicator()),
                      // )
                      )),
              Padding(
                  padding: EdgeInsets.only(top: pd30 ?? 0),
                  child: Column(
                    children: [
                      const Text('帕比寵物'),
                      Container(
                          color: const Color.fromARGB(130, 244, 244, 244),
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Expanded(
                                    child: TextField(
                                  decoration: InputDecoration(
                                      hintText: '輸入手機號碼開始吧',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                )
                            ),
                                const SizedBox(width: 10),
                                SizedBox(
                                    width: 80.0,
                                    child: OutlinedButton(
                                        onPressed: () => debugPrint('被按了XD'),
                                        child: const Text('繼續')))
                              ])),
                      const SizedBox(width: 10),
                    ],
                  ))
            ])));
  }
}
