import 'package:flutter/material.dart';
import 'package:safe_password/pages/edit_password.dart';
import 'package:safe_password/pages/home.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Splash Screen Flutter'),
      routes: {
        '/home': (ctx) => const HomePage(),
        '/edit': (ctx) => EditPasswordPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: _introScreen(),
    );
  }
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 3,
        backgroundColor: Colors.white,
        navigateAfterSeconds: const HomePage(),
        loaderColor: Colors.transparent,
      ),
      Center(
        child: Container(
          child: Image.asset('assets/images/icon.png'),
        ),
      ),
    ],
  );
}
