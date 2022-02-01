import 'dart:math';

import 'package:budget/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double angle = 0;
  double turn = 0.05;

  double wheelAspect = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.rotate(
            angle: angle,
            child: LayoutBuilder(builder: (context, constraints) {
              return GestureDetector(
                dragStartBehavior: DragStartBehavior.down,
                behavior: HitTestBehavior.translucent,
                onPanUpdate: (d) {
                  setState(() {
                    angle += turn;
                  });
                },
                child: Container(
                  width: wheelAspect,
                  height: wheelAspect,
                  decoration: const BoxDecoration(
                      color: primaryColor, shape: BoxShape.circle),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: wheelAspect / 2.5,
                          height: wheelAspect / 2.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                          top: 10,
                          left: wheelAspect / 2,
                          child: Transform.rotate(
                              angle: -angle,
                              child: Tooltip(
                                message: 'Döviz',
                                child: Image.asset('assets/icons/exchange.png'),
                              ))),
                      Positioned(
                          top: wheelAspect / 2 - 30,
                          right: 10,
                          child: Transform.rotate(
                              angle: -angle,
                              child: Tooltip(
                                message: 'Ana Sayfa',
                                child: Image.asset(
                                  'assets/icons/home.png',
                                  color: Colors.white,
                                ),
                              ))),
                      Positioned(
                          top: wheelAspect / 2 - 30,
                          left: 10,
                          child: Transform.rotate(
                              angle: -angle,
                              child: Tooltip(
                                message: 'Kredi Kartlarım',
                                child: Image.asset(
                                  'assets/icons/credit-card.png',
                                ),
                              ))),
                      Positioned(
                          bottom: wheelAspect / 10 - 10,
                          left: wheelAspect / 2 - 30,
                          child: Transform.rotate(
                              angle: -angle,
                              child: Tooltip(
                                message: 'Kripto',
                                child: Image.asset(
                                  'assets/icons/crypto.png',
                                ),
                              ))),
                    ],
                  ),
                ),
              );
            })),
      ),
    );
  }
}
