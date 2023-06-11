import 'package:flutter/material.dart';
import 'node.dart';
import 'tree.dart';

class TreePainter extends CustomPainter { 
  //Define attributes for paint the Tree 
  static final double diameter = 10;
  static final double radio = diameter / 2;
  static final int width = 20;
  late Tree objTree;
  TreePainter(Tree obj) {
    this.objTree = obj;
  }

  //Method for paint tree
  @override
  void paint(Canvas canvas, Size size) {    
    if (objTree != null && objTree!.root != null) {   
      paintN(canvas, size.width / 2, 20, objTree!.root);
    }    
  }

  @override
  bool shouldRepaint(TreePainter oldDelegate) => true;

  void paintN(Canvas canvas, double x, double y, Node? n) {    
    var node =  n?.valueN ?? 0;
    var selected = n?.selected ?? 0;
    if (node != 0) {
      // Define style for circle border of node 
      Paint drawCircleBorder = new Paint()
      ..color = Color.fromARGB(255, 39, 165, 62)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
      if (selected != 0 && n!.selected == true){ 
        drawCircleBorder.color=  Color.fromARGB(255, 255, 20, 20);      
      }    
      // Define style for circle of node
        Paint drawCircle = new Paint()
        ..color = Color.fromARGB(255, 48, 120, 52)
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill
        ..strokeWidth = 0;
        
      // Define style for edge
      Paint edge = new Paint()
        ..color = Color(0xff278ea5)
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 1.5;
      
      final textStyle = TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 10,
        fontWeight: FontWeight.bold,
      );
      // show value of node
      final textSpan = TextSpan(
        text: n!.valueN.toString(),
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: x,
        maxWidth: x,
      );
      final offsetText = Offset(x - 6, y - 6);      
      double extra = objTree!.height(n) * (width / 2);
      //Draw the line between the nodes      
      if (n!.left != null) {
        canvas.drawLine(Offset(x + radio, y - radio),
            Offset(x - width - extra + radio, y + width + radio * 0.2), edge);
      }
      if (n!.right != null) {
        canvas.drawLine(Offset(x + radio, y + radio * 0.2),
            Offset(x + width + extra + radio, y + width + radio), edge);
      }

      canvas.drawCircle(Offset(x, y), diameter, drawCircle);
      canvas.drawCircle(Offset(x, y), diameter, drawCircleBorder);
      textPainter.paint(canvas, offsetText);
      // assign canvas for nodo
      paintN(canvas, x - width - extra, y + width, n.left);
      paintN(canvas, x + width + extra, y + width, n!.right);
    }
  }
}
