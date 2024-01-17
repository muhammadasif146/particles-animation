

import 'dart:math';

import 'package:animation1/particle.dart';
import 'package:flutter/material.dart';

Offset polarToCartesian( double speed, double theta){

  return  Offset(speed *cos(theta), speed * sin(theta));
}

class MyPainterWidget extends CustomPainter {
  MyPainterWidget(this.particles,this.rgn,this.animationValue);
  List<Particles> particles;
  Random rgn;
  double animationValue;
  @override
  void paint(Canvas canvas, Size size) {
    /// update the object
    for (var element in particles) {
      var velocity=polarToCartesian(element.speed, element.theta) ;
      var dx=element.position.dx + velocity.dx, dy=element.position.dy + velocity.dy;
      if (element.position.dx<0 || element.position.dx > size.width){
        dx=rgn.nextDouble() * size.width;
      }
      if(element.position.dy<0 || element.position.dy >size.height){
        dy=rgn.nextDouble() * size.height;
      }
      element.position=Offset(dx, dy);
    }

    for (var element in particles) {
      var paint =Paint();
      paint.color=Colors.red;
      canvas.drawCircle(element.position, element.radius, paint);
    }
    /// paint the object
var dx=size.width/2;
var dy=size.height/2;
var c= Offset(dx, dy);
var radius= 100.0;
var paint=Paint();
paint.color=Colors.red;
canvas.drawCircle(c, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}