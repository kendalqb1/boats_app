import 'dart:math';

import 'package:boats_app/models/boat.dart';
import 'package:flutter/material.dart';

class BoatDetails extends StatelessWidget {
  final Boat boat;

  const BoatDetails({
    Key? key,
    required this.boat,
  }) : super(key: key);

  final _dxTrans = 80.0;
  final _dyTrans = -100.0;
  final _angleRot = (pi * -.5);

  Widget _flightShuttleBuilder(
      Animation animation, HeroFlightDirection flightDirection) {
    final isPop = flightDirection == HeroFlightDirection.pop;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final value = isPop
            ? Curves.easeInBack.transform(animation.value)
            : Curves.easeOutBack.transform(animation.value);
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..translate(_dxTrans * value, _dyTrans * value, 0)
            ..rotateZ(_angleRot * value),
          child: child,
        );
      },
      child: _ImageBoat(
        boatImagePath: boat.imgPath,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final animateItemNotifier = ValueNotifier(false);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      animateItemNotifier.value = true;
    });
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: boat.model,
                  flightShuttleBuilder:
                      (_, animation, flightDirection, ___, ____) {
                    return _flightShuttleBuilder(animation, flightDirection);
                  },
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..translate(_dxTrans, _dyTrans, 0)
                      ..rotateZ(_angleRot),
                    child: _ImageBoat(
                      boatImagePath: boat.imgPath,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -MediaQuery.of(context).size.height * .32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        boat.model,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'By ',
                          children: [
                            TextSpan(
                              text: boat.by,
                              style: TextStyle(
                                color: Colors.grey[900],
                              ),
                            ),
                          ],
                          style: TextStyle(
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: animateItemNotifier,
                        builder: (context, value, child) {
                          return TweenAnimationBuilder<double>(
                              curve: Curves.fastOutSlowIn,
                              tween: Tween(begin: 1.0, end: value ? 0.0 : 1.0),
                              duration: const Duration(milliseconds: 600),
                              builder: (context, value, child) {
                                return Transform.translate(
                                  offset: Offset(0, (-50.0 * value)),
                                  child: Opacity(
                                    opacity: 1 - value,
                                    child: child,
                                  ),
                                );
                              },
                              child: child);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              boat.description,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              'SPECS',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 10),
                            _BoatSpecsList(boat: boat),
                            const SizedBox(height: 20),
                            const Text(
                              'GALLERY',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 200.0,
                              child: ListView.builder(
                                itemCount: boat.gallery.length,
                                scrollDirection: Axis.horizontal,
                                itemExtent: 220,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final galleryPath = boat.gallery[index];
                                  return Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.asset(
                                      galleryPath,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: const Alignment(-.9, -.9),
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.black12,
              child: const Icon(Icons.close),
              onPressed: () {
                animateItemNotifier.value = false;
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}

class _BoatSpecsList extends StatelessWidget {
  const _BoatSpecsList({
    Key? key,
    required this.boat,
  }) : super(key: key);

  final Boat boat;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        boat.specs.length,
        (index) {
          final key = boat.specs.keys.toList()[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    key,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    boat.specs[key]!,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ImageBoat extends StatelessWidget {
  const _ImageBoat({
    Key? key,
    required this.boatImagePath,
  }) : super(key: key);

  final String boatImagePath;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: .85,
      child: Image.asset(boatImagePath),
    );
  }
}
