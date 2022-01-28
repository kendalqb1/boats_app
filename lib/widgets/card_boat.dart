import 'dart:ui';

import 'package:boats_app/models/boat.dart';
import 'package:flutter/material.dart';

class CardBoat extends StatelessWidget {
  final Boat boat;
  final double factorChange;
  final VoidCallback onTap;

  const CardBoat({
    Key? key,
    required this.boat,
    required this.factorChange,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: (1 - factorChange).clamp(0.0, 1.0),
      child: Column(
        children: [
          Expanded(
            child: Transform.scale(
              scale: lerpDouble(1.0, 0.7, factorChange)!,
              alignment: const Alignment(0, 0.5),
              child: Hero(
                tag: boat.model,
                child: Image.asset(boat.imgPath),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            boat.model,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 27,
            ),
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
                height: 1,
              ),
            ),
          ),
          TextButton.icon(
            label: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
            ),
            icon: const Text('SPEC'),
            onPressed: onTap,
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                Colors.blue[900]!,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
