import 'package:agrigreens/MQTT/mqtt_client.dart';
import 'package:agrigreens/auth/screens/login_screen.dart';
import 'package:agrigreens/global/app_themes.dart';
import 'package:agrigreens/global/client.dart';
import 'package:agrigreens/repository/auth_repository/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:agrigreens/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthRepo()));
  // MQTTClientWrapper newclient = createClient();
  // ignore: unused_local_variable
  MQTTClientWrapper newclient = client;
  runApp(const GetMaterialApp(
    // home: MyApp(),
    home: LoginScreen(),
  ));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgriGreens',
      theme: Themes.darkthemeData,
      darkTheme: Themes.darkthemeData,
      // theme: ThemeData(
      //     colorScheme: ColorScheme.fromSwatch().copyWith(
      //   primary: Color.fromRGBO(17, 70, 60, 1),
      //   secondary: Color.fromRGBO(255, 255, 255, 1),
      // )
      // primarySwatch: Colors.blue,
      // ),
      home: const MyHomePage(title: 'AgriGreens'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Themes.mainthemeData,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              FloatingActionButton(onPressed: () {
                AuthRepo.instance.logout();
              })
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
