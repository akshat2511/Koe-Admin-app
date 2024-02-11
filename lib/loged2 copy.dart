// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings, library_private_types_in_public_api

import 'package:KoeAdmin/homescreen.dart';
import 'package:KoeAdmin/loged.dart';
// import 'package:KoeAdmin/menu.dart';
import 'package:KoeAdmin/splash.dart';
import 'package:KoeAdmin/upload.dart';
import 'package:flutter/material.dart';
import 'package:KoeAdmin/data.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Logedin2 extends StatefulWidget {
  const Logedin2({super.key});
  @override
  _LogedinState createState() => _LogedinState();
}

class _LogedinState extends State<Logedin2> {
  var _selectedIndex = 2;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WELCOME"),
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor:
                  const Color.fromARGB(255, 211, 161, 91).withOpacity(.1),
              hoverColor:
                  const Color.fromARGB(255, 211, 161, 91).withOpacity(.1),
              gap: 8,
              activeColor: Color.fromARGB(255, 7, 6, 6),
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDatabase.get(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                // var rdata = snapshot.data;
                //return Center(child: Text(snapshot.data.toString()));
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading: Text(
                          (index + 1).toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                        title: Text(
                          snapshot.data[index]['name'].toString(),
                          style: const TextStyle(fontSize: 15),
                        ),
                        subtitle: Text(
                          '${snapshot.data[index]['phone'].toInt()}|' +
                              ' ${snapshot.data[index]['person']}|' +
                              '${snapshot.data[index]['date']}|' +
                              '${snapshot.data[index]['time']}|' +
                              '${snapshot.data[index]["message"]}',
                          style: const TextStyle(fontSize: 9),
                        ),
                        isThreeLine: true,
                        trailing: IconButton(
                          onPressed: () {
                            MongoDatabase.del2(
                                snapshot.data[index]['phone'].toInt());
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Logedin2(),
                                ));
                          },
                          icon: const Icon(Icons.delete_forever_rounded),
                        ));
                  },
                  itemCount: snapshot.data.length,
                );
              } else {
                return const Center(
                  child: Text('No data available'),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
//  ListView.builder(
//           itemBuilder: (context, index) => const ListTile(
//             title: Text('temp'),
//             subtitle: Text('data'),
//           ),itemCount: 10,
//         ));