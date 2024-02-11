import 'dart:async';
import 'package:flutter/material.dart';
import 'package:KoeAdmin/main.dart';

// void fun() async {
//   await MongoDatabase.connect();
// }

class SizeTransitionExample extends StatefulWidget {
  const SizeTransitionExample({super.key});

  @override
  State<SizeTransitionExample> createState() => _SizeTransitionExampleState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _SizeTransitionExampleState extends State<SizeTransitionExample>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      //fun();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ));
    });
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 161, 91),
      body: SizeTransition(
        sizeFactor: _animation,
        axis: Axis.horizontal,
        axisAlignment: -1,
        child: Center(
          child: Container(
              width: 100,
              height: 90,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 101, 79, 10),
                  borderRadius: BorderRadius.circular(9)),
              child: Image.asset('images/logo1.jpg')),
        ),
      ),
    );
  }
}
