import 'dart:async';

import 'package:flutter/material.dart';

class TableScrollView extends StatefulWidget {
  final Widget child;

  final ValueChanged<Offset>? onScroll;

  final double maxWidth;

  final double maxHeight;

  final StreamController? horizontalPixelsStreamController;

  final StreamController? verticalPixelsStreamController;

  final Function(Offset position) onTapUp;

  const TableScrollView({
    Key? key,
    required this.child,
    this.onScroll,
    this.maxWidth = double.infinity,
    this.maxHeight = double.infinity,
    this.horizontalPixelsStreamController,
    this.verticalPixelsStreamController,
    required this.onTapUp,
  }) : super(key: key);

  @override
  State<TableScrollView> createState() => _TableScrollViewState();
}

class _TableScrollViewState extends State<TableScrollView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  Offset _position = const Offset(0, 0);
  Offset _lastFocalPoint = const Offset(0, 0);
  final GlobalKey _positionedKey = GlobalKey();

  RenderBox? get renderBox {
    return context.findRenderObject() as RenderBox?;
  }

  double get containerWidth {
    return renderBox?.size.width ?? 0;
  }

  double get containerHeight {
    return renderBox?.size.height ?? 0;
  }

  RenderBox? get positionedRenderBox {
    return _positionedKey.currentContext?.findRenderObject() as RenderBox?;
  }

  double get positionedWidth {
    return positionedRenderBox?.size.width ?? 0;
  }

  double get positionedHeight {
    return positionedRenderBox?.size.height ?? 0;
  }

  void _emitScroll() {
    if (widget.onScroll != null) {
      widget.onScroll!(_position);
    }
  }

  Offset _rectifyChildPosition({
    required Offset position,
    Offset offset = const Offset(0, 0),
  }) {
    Offset containerScaled = Offset(containerWidth, containerHeight);
    double x = position.dx;
    double y = position.dy;

    if (x + offset.dx < containerScaled.dx - widget.maxWidth) {
      x = containerScaled.dx - widget.maxWidth - offset.dx;
    }

    if (y + offset.dy < containerScaled.dy - widget.maxHeight) {
      y = containerScaled.dy - widget.maxHeight - offset.dy;
    }

    if (x + offset.dx > 0.0) {
      x = -offset.dx;
    }

    if (y + offset.dy > 0.0) {
      y = -offset.dy;
    }

    return Offset(x, y);
  }

  void _handleFlingAnimation() {
    if (_controller.isAnimating && _animation.value.distance > 0.0) {
      Offset newPosition = _rectifyChildPosition(
        position: _position + _animation.value,
      );

      setState(() {
        _position = newPosition;
      });

      _emitScroll();
    }
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _lastFocalPoint = renderBox!.globalToLocal(details.focalPoint);
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    Offset focalPoint = renderBox!.globalToLocal(details.focalPoint);
    Offset deltaScaled = focalPoint - _lastFocalPoint;
    Offset newPosition = _rectifyChildPosition(
      position: _position + deltaScaled,
      offset: const Offset(0.0, 0.0),
    );

    setState(() {
      _lastFocalPoint = focalPoint;
      _position = newPosition;
    });

    _emitScroll();
  }

  void _handleScaleEnd(ScaleEndDetails details) {
    Offset velocity = details.velocity.pixelsPerSecond;
    if (velocity.distance > 0.0) {
      _animation = Tween<Offset>(
        begin: velocity,
        end: const Offset(0.0, 0.0),
      ).animate(_controller);
      _controller.fling(velocity: 2);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    widget.onTapUp(Offset(
      details.localPosition.dx - _position.dx,
      details.localPosition.dy - _position.dy,
    ));
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this)
      ..addListener(_handleFlingAnimation);

    widget.horizontalPixelsStreamController!.stream.listen((pixels) {
      setState(() {
        _position = Offset(-pixels, _position.dy);
      });
    });

    widget.verticalPixelsStreamController!.stream.listen((pixels) {
      setState(() {
        _position = Offset(_position.dx, -pixels);
      });
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _handleScaleStart,
      onScaleUpdate: _handleScaleUpdate,
      onScaleEnd: _handleScaleEnd,
      onTapUp: _handleTapUp,
      child: Stack(
        children: <Widget>[
          Positioned(
            key: _positionedKey,
            left: _position.dx,
            top: _position.dy,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
