


import 'dart:math';

import 'package:animation1/particle.dart';
import 'package:flutter/material.dart';

import 'my_painter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  late List <Particles> particles;
 late Animation<double> animation;
late  AnimationController controller;
int particleCount=500;
  double maxRadius=6;
  double maxSpeed=0.2;
  double maxTheta=2.0 *pi;
  Color getRandomColor(){
    var a= rgn.nextInt(255);
    var r= rgn.nextInt(255);
    var g= rgn.nextInt(255);
    var b= rgn.nextInt(255);
    return  Color.fromARGB(a, r, g, b);
  }
Random rgn= Random(DateTime.now().millisecondsSinceEpoch);
  @override
  void initState() {
    controller=AnimationController(vsync: this,duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 100).animate(controller)
    ..addListener(() {
      setState(() {});
    })
    ..addStatusListener((status) {
      // if (status == AnimationStatus.completed) {
      //   controller.repeat();
      // } else if (status == AnimationStatus.dismissed) {
      //   controller.forward();
      // }
    })
      ..addStatusListener((status) => print('$status'));
    controller.forward();
    particles=List.generate(200, (index) {
      var p= Particles();
      p.color=getRandomColor();
      p.position=const Offset(-1, -1);
      p.speed=rgn.nextDouble() * maxSpeed;
      p.theta=rgn.nextDouble() * maxTheta;
      p.radius=rgn.nextDouble() * maxRadius;
      return p;
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          backgroundColor: Theme.of(context).colorScheme.inversePrimary,

          title: Text(widget.title),
        ),
        body:
        CustomPaint(painter: MyPainterWidget(particles,rgn,animation.value),child:Container() ,)

    );
  }
}
