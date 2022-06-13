import 'package:flutter/material.dart';

class BouncingSpinner extends StatefulWidget {
  final int length;
  final double radius;
  final Color color1;
  Color? color2;
  double? offset;
  Duration? duration;

  BouncingSpinner(
      {Key? key,
      required this.length,
      required this.radius,
      required this.color1,
      this.color2,
      this.offset,
      this.duration})
      : super(key: key) {
    offset ??= radius / 2;
    color2 ??= color1;
    duration ??= const Duration(milliseconds: 1500);
  }

  @override
  State<BouncingSpinner> createState() => _BouncingSpinnerState();
}

class _BouncingSpinnerState extends State<BouncingSpinner>
    with SingleTickerProviderStateMixin {
  late final Animation animation;
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: widget.duration);
    animation = Tween<double>(begin: 0.4, end: 0.6).animate(controller)
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          controller.forward();
        } else if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.radius * widget.length,
      child: Stack(
        alignment: Alignment.topCenter,
        children: List<Widget>.generate(widget.length, (index) {
          final isEven = index % 2 == 0;
          final offset = widget.offset! * index;
          final color = isEven ? widget.color2 : widget.color1;
          final scale =
              isEven ? animation.value : (1 - animation.value as double);

          return Positioned(
            left: offset,
            child: Transform.scale(
              scale: scale,
              child: Container(
                width: widget.radius,
                height: widget.radius,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
