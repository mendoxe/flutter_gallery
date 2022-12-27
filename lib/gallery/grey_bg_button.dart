import 'package:flutter/material.dart';

class GreyBgButton extends StatelessWidget {
  const GreyBgButton({
    Key? key,
    this.right,
    this.left,
    this.top,
    this.bottom,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final double? right;
  final double? left;
  final double? top;
  final double? bottom;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: right,
      left: left,
      top: top,
      bottom: bottom,
      child: Container(
        color: Colors.black.withOpacity(0.15),
        child: IconButton(
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
