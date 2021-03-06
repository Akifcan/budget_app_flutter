import 'package:budget/core/navigator_service.dart';
import 'package:budget/style.dart';
import 'package:budget/views/cards/my_cards.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double angle = 0;
  double turn = 0.05;

  double wheelAspect = 300;
  final localAuth = LocalAuthentication();

  auth() async {
    bool didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate to show account balance');
    if (didAuthenticate) {
      NavigationService.push(const MyCards());
    }
  }

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
                                message: 'D??viz',
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
                          child: GestureDetector(
                            onTap: auth,
                            child: Transform.rotate(
                                angle: -angle,
                                child: Tooltip(
                                  message: 'Kredi Kartlar??m',
                                  child: Image.asset(
                                    'assets/icons/credit-card.png',
                                  ),
                                )),
                          )),
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
