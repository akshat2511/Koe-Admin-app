import 'package:KoeAdmin/homescreen.dart';
import 'package:KoeAdmin/menu.dart';
import 'package:KoeAdmin/upload.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:KoeAdmin/data.dart';
// import 'package:KoeAdmin/loged.dart';
import 'package:KoeAdmin/splash.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
 //bool kDebugMode = true;
  MongoDatabase.connect();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KoeAdmin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:const Color.fromARGB(255, 211, 161, 91)),
        useMaterial3: true,
      ),
      home: const SizeTransitionExample(),
    );
  }
}

final TextEditingController _email = TextEditingController();
final TextEditingController pass = TextEditingController();

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Koe-The-Kafe'),
          backgroundColor: const Color.fromARGB(255, 211, 161, 91),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(250))),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: TextField(
                  controller: _email,
                  decoration: const InputDecoration(
                    prefix: Icon(Icons.man),
                    label: Text("Enter User_ID"),
                    contentPadding: EdgeInsets.all(10),
                    filled: true,
                    fillColor: Color.fromARGB(118, 215, 155, 66),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(118, 215, 155, 66),
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(118, 215, 155, 66),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
              ),
              Center(
                child: TextField(
                  controller: pass,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: const InputDecoration(
                    prefix: Icon(Icons.lock_outline),
                    filled: true,
                    fillColor: Color.fromARGB(118, 215, 155, 66),
                     label: Text("Enter Password"),
                    contentPadding: EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(118, 215, 155, 66),
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(118, 215, 155, 66),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    String umail = _email.text.toString();
                    String p = pass.text.toString();
                    if (umail == "akshat" && p == "cafe") {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  Homescreen(),
                          ));
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ));
  }
}
