import 'package:flutter/material.dart';
import 'package:yalda_students_notes/presentation/widgets/top_snackbar/safe_area_values.dart';
import 'package:yalda_students_notes/presentation/widgets/top_snackbar/tap_bounce_container.dart';

typedef ControllerCallback = void Function(AnimationController);

enum DismissType { onTap, onSwipe, none }

OverlayEntry? _previousEntry;

void showTopSnackBar(
  BuildContext context,
  Widget child, {
  Duration animationDuration = const Duration(milliseconds: 1200),
  Duration reverseAnimationDuration = const Duration(milliseconds: 550),
  Duration displayDuration = const Duration(milliseconds: 3000),
  VoidCallback? onTap,
  OverlayState? overlayState,
  bool persistent = false,
  ControllerCallback? onAnimationControllerInit,
  EdgeInsets padding = const EdgeInsets.all(16),
  Curve curve = Curves.elasticOut,
  Curve reverseCurve = Curves.linearToEaseOut,
  SafeAreaValues safeAreaValues = const SafeAreaValues(),
  DismissType dismissType = DismissType.onTap,
  DismissDirection dismissDirection = DismissDirection.up,
}) async {
  overlayState ??= Overlay.of(context);
  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) {
      return TopSnackBar(
        child: child,
        onDismissed: () {
          if (overlayEntry.mounted && _previousEntry == overlayEntry) {
            overlayEntry.remove();
            _previousEntry = null;
          }
        },
        animationDuration: animationDuration,
        reverseAnimationDuration: reverseAnimationDuration,
        displayDuration: displayDuration,
        onTap: onTap,
        persistent: persistent,
        onAnimationControllerInit: onAnimationControllerInit,
        padding: padding,
        curve: curve,
        reverseCurve: reverseCurve,
        safeAreaValues: safeAreaValues,
        dismissType: dismissType,
        dismissDirection: dismissDirection,
      );
    },
  );

  if (_previousEntry != null && _previousEntry!.mounted) {
    _previousEntry?.remove();
  }
  overlayState?.insert(overlayEntry);
  _previousEntry = overlayEntry;
}

class TopSnackBar extends StatefulWidget {
  final Widget child;
  final VoidCallback onDismissed;
  final Duration animationDuration;
  final Duration reverseAnimationDuration;
  final Duration displayDuration;
  final VoidCallback? onTap;
  final ControllerCallback? onAnimationControllerInit;
  final bool persistent;
  final EdgeInsets padding;
  final Curve curve;
  final Curve reverseCurve;
  final SafeAreaValues safeAreaValues;
  final DismissType dismissType;
  final DismissDirection dismissDirection;

  const TopSnackBar({
    Key? key,
    required this.child,
    required this.onDismissed,
    required this.animationDuration,
    required this.reverseAnimationDuration,
    required this.displayDuration,
    this.onTap,
    this.persistent = false,
    this.onAnimationControllerInit,
    required this.padding,
    required this.curve,
    required this.reverseCurve,
    required this.safeAreaValues,
    this.dismissType = DismissType.onTap,
    this.dismissDirection = DismissDirection.up,
  }) : super(key: key);

  @override
  _TopSnackBarState createState() => _TopSnackBarState();
}

class _TopSnackBarState extends State<TopSnackBar>
    with SingleTickerProviderStateMixin {
  late Animation offsetAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    _setupAndStartAnimation();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _setupAndStartAnimation() async {
    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      reverseDuration: widget.reverseAnimationDuration,
    );

    widget.onAnimationControllerInit?.call(animationController);

    Tween<Offset> offsetTween = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    );

    offsetAnimation = offsetTween.animate(
      CurvedAnimation(
        parent: animationController,
        curve: widget.curve,
        reverseCurve: widget.reverseCurve,
      ),
    )..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          await Future.delayed(widget.displayDuration);
          _dismiss();
        }

        if (status == AnimationStatus.dismissed) {
          if (mounted) {
            widget.onDismissed.call();
          }
        }
      });

    if (mounted) {
      animationController.forward();
    }
  }

  void _dismiss() {
    if (!widget.persistent && mounted) {
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.padding.top,
      left: widget.padding.left,
      right: widget.padding.right,
      child: SlideTransition(
        position: offsetAnimation as Animation<Offset>,
        child: SafeArea(
          top: widget.safeAreaValues.top,
          bottom: widget.safeAreaValues.bottom,
          left: widget.safeAreaValues.left,
          right: widget.safeAreaValues.right,
          minimum: widget.safeAreaValues.minimum,
          maintainBottomViewPadding:
              widget.safeAreaValues.maintainBottomViewPadding,
          child: _buildDismissibleChild(),
        ),
      ),
    );
  }

  Widget _buildDismissibleChild() {
    switch (widget.dismissType) {
      case DismissType.onTap:
        return TapBounceContainer(
          onTap: () {
            if (mounted) {
              widget.onTap?.call();
              _dismiss();
            }
          },
          child: widget.child,
        );
      case DismissType.onSwipe:
        return Dismissible(
          direction: widget.dismissDirection,
          key: UniqueKey(),
          onDismissed: (direction) => _dismiss(),
          child: widget.child,
        );
      case DismissType.none:
        return widget.child;
    }
  }
}
