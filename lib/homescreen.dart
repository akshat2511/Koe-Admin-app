// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:KoeAdmin/data.dart';
import 'package:KoeAdmin/hero.dart';
import 'package:KoeAdmin/loged.dart';
import 'package:KoeAdmin/loged2.dart';
// import 'package:KoeAdmin/splash.dart';
import 'package:KoeAdmin/upload.dart';
import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Homescreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables

  Homescreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  var _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          backgroundColor: const Color.fromARGB(255, 211, 161, 91),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: const Color.fromARGB(255, 211, 161, 91).withOpacity(.1),
              )
            ],
          ),
          // ignore: prefer_const_constructors
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor:
                    const Color.fromARGB(255, 211, 161, 91).withOpacity(.1),
                hoverColor:
                    const Color.fromARGB(255, 211, 161, 91).withOpacity(.1),
                gap: 8,
                activeColor: const Color.fromARGB(255, 7, 6, 6),
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor:
                    const Color.fromARGB(255, 211, 161, 91).withOpacity(.3),
                color: Colors.black,
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                    onPressed: () {
                      MongoDatabase.getcoll("photoforhero");
                      dynamic data1 = MongoDatabase.get();
                      MongoDatabase.getcoll("specials");
                      dynamic data2 = MongoDatabase.get();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Homescreen(),
                          ));
                    },
                  ),
                  GButton(
                      icon: LineIcons.digitalTachograph,
                      text: 'DATA',
                      onPressed: () {
                        MongoDatabase.getcoll("photoforheros");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ));
                      }),
                  GButton(
                      icon: LineIcons.book,
                      text: 'Bookings',
                      onPressed: () {
                        MongoDatabase.getcoll('bookings');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const Logedin2();
                        }));
                      }),
                  GButton(
                      icon: LineIcons.fire,
                      text: 'Workshops',
                      onPressed: () {
                        MongoDatabase.getcoll('caves');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const Logedin();
                        }));
                      }),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/coffeeroaster.jpg"),
                fit: BoxFit.fitHeight),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: ActionSlider.dual(
                  backgroundBorderRadius: BorderRadius.circular(30.0),
                  foregroundBorderRadius: BorderRadius.circular(30.0),
                  width: MediaQuery.of(context).size.width - 50,
                  backgroundColor: Color.fromARGB(255, 183, 153, 111).withOpacity(0.7),
                  startChild: const Text('HeroSlider'),
                  endChild: const Text('Speciality'),
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Transform.rotate(
                        angle: 0.5 * pi,
                        child: const Icon(Icons.catching_pokemon, size: 28.0)),
                  ),
                  startAction: (controller) async {
                    controller.loading(); //starts loading animation
                    await Future.delayed(const Duration(seconds: 1));
                    await MongoDatabase.getcoll('photoforheros');
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const Heroslider();
                      },
                    ));
                    // akshat = "photoforheros";
                    controller.success();
                    await Future.delayed(const Duration(seconds: 1));
                    controller.reset(); //starts success animation
                    // await Future.delayed(const Duration(seconds: 1));
                    // controller.reset(); //resets the slider
                  },
                  endAction: (controller) async {
                    controller.loading(); //starts loading animation
                    await MongoDatabase.getcoll('specials');
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const Heroslider();
                      },
                    ));
                    await Future.delayed(const Duration(seconds: 1));

                    // akshat = "specials";
                    controller.success();
                    await Future.delayed(const Duration(seconds: 1));
                    controller.reset();

                    //starts success animation
                    // await Future.delayed(const Duration(seconds: 1));
                    // controller.reset(); //resets the slider
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
