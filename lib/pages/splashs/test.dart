import 'package:flutter/material.dart';

class ArrowPopAndSlide extends StatefulWidget {
  @override
  _ArrowPopAndSlideState createState() => _ArrowPopAndSlideState();
}

class _ArrowPopAndSlideState extends State<ArrowPopAndSlide> {
  double _top = 0;
  double _left = 0;
  bool _animating = false;

  void _startAnimation() async {
    if (_animating) return; // Biar ga bisa spam klik
    setState(() {
      _animating = true;
    });

    // POP ke atas dikit
    setState(() {
      _top = -10; // naik 10px
    });

    await Future.delayed(Duration(milliseconds: 200));

    // Balik ke posisi normal
    setState(() {
      _top = 0;
    });

    // Tunggu 1 detik sebelum geser kanan
    await Future.delayed(Duration(milliseconds: 250));

    // Geser ke kanan cepat
    setState(() {
      _left = 150; // geser kanan 150px
    });

    // Reset biar bisa animasi ulang
    await Future.delayed(Duration(milliseconds: 800));
    setState(() {
      _left = 0;
      _animating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Arrow Pop + Slide")),
      body: Center(
        child: GestureDetector(
          onTap: _startAnimation,
          child: Stack(
            children: [
              Container(width: 200, height: 80, color: Colors.grey.shade300),
              AnimatedPositioned(
                duration: Duration(milliseconds: 200),
                top: _top,
                left: _left,
                child: Icon(
                  Icons.arrow_right_rounded,
                  size: 50,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
