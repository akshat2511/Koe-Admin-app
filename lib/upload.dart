// ignore: file_names
// ignore_for_file: await_only_futures

import 'dart:io';
import 'dart:math';
import 'package:KoeAdmin/data.dart';
import 'package:KoeAdmin/homescreen.dart';
import 'package:KoeAdmin/loged.dart';
import 'package:KoeAdmin/loged2.dart';
import 'package:KoeAdmin/splash.dart';
import 'package:action_slider/action_slider.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_imagekit/flutter_imagekit.dart';
// import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:imagekit_io/imagekit_io.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectedIndex = 1;

  XFile? image;
  String? akshat;
  final ImagePicker picker = ImagePicker();
  final TextEditingController _caption = TextEditingController();
  final TextEditingController _caption1 = TextEditingController();

  final TextEditingController _caption2 = TextEditingController();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    XFile img = (await picker.pickImage(source: media)) as XFile;

    setState(() {
      image = img;
    });
  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Data'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _caption,
              decoration: const InputDecoration(
                  label: Text(
                    'Enter Title',
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(118, 215, 155, 66)),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight:Radius.circular(25))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight:Radius.circular(25))),
                  filled: true,
                  fillColor: Color.fromARGB(118, 215, 155, 66)),
            ),
            TextField(
              controller: _caption1,
              decoration: const InputDecoration(
                  label: Text(
                    'Enter Caption',
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(118, 215, 155, 66)),
                      ),
                  focusedBorder: OutlineInputBorder(
                     ),
                  filled: true,
                  fillColor: Color.fromARGB(118, 215, 155, 66)),
            ),
            TextField(
              controller: _caption2,
              decoration: const InputDecoration(
                  label: Text(
                    'Enter Details',
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(118, 215, 155, 66)),
                     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight:Radius.circular(25))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight:Radius.circular(25))),
                  filled: true,
                  fillColor: Color.fromARGB(118, 215, 155, 66)),
            ),

            const SizedBox(
              height: 10,
            ),
            //if image not null show the image
            //if image null show text
            image != null
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              //to show image, you type like this.
                              File(image!.path),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width-50,
                              height: 300,
                            ),
                          ),
                        ),const SizedBox(height: 20,),
                        ActionSlider.dual(
                          backgroundBorderRadius: BorderRadius.circular(30.0),
                          foregroundBorderRadius: BorderRadius.circular(30.0),
                          width: MediaQuery.of(context).size.width-50,
                          backgroundColor: Colors.white,
                          startChild: const Text('Slider'),
                          endChild: const Text('Speciality'),
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: Transform.rotate(
                                angle: 0.5 * pi,
                                child: const Icon(Icons.catching_pokemon,
                                    size: 28.0)),
                          ),
                          startAction: (controller) async {
                            controller.loading(); //starts loading animation
                            await Future.delayed(const Duration(seconds: 2));
                            akshat = "photoforheros";
                            controller.success(); //starts success animation
                            // await Future.delayed(const Duration(seconds: 1));
                            // controller.reset(); //resets the slider
                          },
                          endAction: (controller) async {
                            controller.loading(); //starts loading animation
                            await Future.delayed(const Duration(seconds: 2));
                            akshat = "specials";
                            controller.success(); //starts success animation
                            // await Future.delayed(const Duration(seconds: 1));
                            // controller.reset(); //resets the slider
                          },
                        ),
                        const SizedBox(height: 20,),
                        ActionSlider.standard(
                          child: const Text('Slide to confirm'),
                          action: (controller) async {
                            controller.loading();

                            // Get the URL first
                             await Imagecdn.insert(akshat!,
                                image,
                                _caption.text.toString(),
                                _caption1.text.toString(),
                                _caption2.text.toString());
                            await Future.delayed(const Duration(seconds: 3));

                            controller.success();
                          },
                        )
                      ],
                    ),
                  )
                : Column(children: [
                    ElevatedButton(
                      onPressed: () {
                        myAlert();
                      },
                      child: const Text('Upload Photo'),
                    ),
                    const Text(
                      "No Image",
                      style: TextStyle(fontSize: 20),
                    ),
                  ])
          ],
        ),
      ),
    );
  }
}
