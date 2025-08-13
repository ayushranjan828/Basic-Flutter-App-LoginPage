import 'package:flutter/material.dart';
import 'dart:async';
import '../theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: Duration(milliseconds: 900));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
    Timer(Duration(milliseconds: 1400), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: Center(
        child: FadeTransition(
          opacity: _anim,
          child: ScaleTransition(scale: _anim, child: _logo()),
        ),
      ),
    );
  }

  Widget _logo() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Hero(tag: 'logo', child: Container(
        width: 110, height: 110,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: [Colors.white.withOpacity(0.18), Colors.white30]),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0,4))],
        ),
        child: Center(child: Icon(Icons.photo_library_rounded, size: 56, color: Colors.white)),
      )),
      SizedBox(height: 18),
      Text('Picsum Advanced', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
      SizedBox(height: 6),
      Text('Beautiful images. Fast UI.', style: TextStyle(color: Colors.white70)),
    ]);
  }
}
