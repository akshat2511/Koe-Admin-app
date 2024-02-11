// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:KoeAdmin/data.dart';
import 'package:KoeAdmin/homescreen.dart';
import 'package:KoeAdmin/loged.dart';
import 'package:KoeAdmin/loged2.dart';
import 'package:KoeAdmin/splash.dart';
import 'package:KoeAdmin/upload.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});
  @override
  _Me createState() => _Me();
}

class _Me extends State<Menu> {
  var _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'DATA',
      style: optionStyle,
    ),
    Text(
      'Bookings',
      style: optionStyle,
    ),
    Text(
      'Workshop',
      style: optionStyle,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Options'),
          backgroundColor: const Color.fromARGB(255, 211, 161, 91),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(250))),
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
                rippleColor: const Color.fromARGB(255, 211, 161, 91).withOpacity(.1),
                hoverColor:const Color.fromARGB(255, 211, 161, 91).withOpacity(.1),
                gap: 8,
                activeColor: const Color.fromARGB(255, 7, 6, 6),
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: const Color.fromARGB(255, 211, 161, 91).withOpacity(.3),
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
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Center(
              //   child: ElevatedButton(
              //       onPressed: () async {
              //         MongoDatabase.getcoll('caves');
              //         Navigator.push(context, MaterialPageRoute(
              //           builder: (context) {
              //             //  await MongoDatabase.connect('caves');
              //             return const Logedin();
              //           },
              //         ));
              //       },
              //       child: const Text('Event Registrations')),
              // ),
              // const SizedBox(
              //   height: 100,
              //   width: 100,
              // ),
              // Center(
              //   child: ElevatedButton(
              //       onPressed: () async {
              //         MongoDatabase.getcoll('bookings');
              //         Navigator.push(context, MaterialPageRoute(
              //           builder: (context) {
              //             return const Logedin2();
              //           },
              //         ));
              //       },
              //       child: const Text('Bookings')),
              // ),
              _widgetOptions.elementAt(_selectedIndex)
            ],
          ),
        ));
  }
}
