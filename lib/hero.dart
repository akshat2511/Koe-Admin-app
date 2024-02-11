// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings, library_private_types_in_public_api

import 'package:KoeAdmin/homescreen.dart';
import 'package:KoeAdmin/loged.dart';
import 'package:KoeAdmin/loged2.dart';
// import 'package:KoeAdmin/menu.dart';
import 'package:KoeAdmin/splash.dart';
import 'package:KoeAdmin/upload.dart';
import 'package:flutter/material.dart';
import 'package:KoeAdmin/data.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Heroslider extends StatefulWidget {
  const Heroslider({super.key});
  @override
  _LogedinState createState() => _LogedinState();
}

class _LogedinState extends State<Heroslider> {
  var _selectedIndex = 0;

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
              activeColor: const Color.fromARGB(255, 7, 6, 6),
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
                        leading: InkWell(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data[index]['imageurl'].toString()),
                          ),
                          onDoubleTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    
                                    content: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6,
                                      child: Image.network( snapshot.data[index]["imageurl"].toString()),
                                    ),
                                  );
                                });
                          },
                        ),
                        title: Text(
                          snapshot.data[index]['text1'].toString(),
                          style: const TextStyle(fontSize: 15),
                        ),
                        subtitle: Text(
                          '${snapshot.data[index]['text2']}|' +
                              ' ${snapshot.data[index]['text3']}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        isThreeLine: true,
                        trailing: IconButton(
                          onPressed: () {
                            MongoDatabase.del3(snapshot.data[index]['text2']);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Heroslider(),
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
