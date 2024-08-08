// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  String? image;
  String text;
  Color color;
  Function()? ontap;
  AnimatedButton(
      {super.key,
      required this.text,
      this.image,
      required this.color,
      this.ontap});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  onTapCancel() {
    _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scale = 1 - _animationController.value;
    return GestureDetector(
      onTap: widget.ontap == null
          ? null
          : () {
            
              widget.ontap;
            },
      onTapDown: widget.ontap == null ? null : onTapDown,
      onTapUp: widget.ontap == null ? null : onTapUp,
      onTapCancel: widget.ontap == null ? null : onTapCancel,
      child: Transform.scale(
        scale: scale,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: widget.image == null
                    ? const Color.fromARGB(255, 183, 19, 7)
                    : Colors.black),
          ),
          child: Padding(
            padding: widget.image == null
                ? const EdgeInsets.only(left: 0)
                : const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: widget.image == null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                if (widget.image != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(widget.image!),
                  ),
                if (widget.image != null)
                  const SizedBox(
                    width: 16,
                  ),
                Text(
                  widget.text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: widget.image == null ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
