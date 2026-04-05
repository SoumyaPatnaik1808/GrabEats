import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SwipeButton extends StatefulWidget {
  final VoidCallback onComplete;

  const SwipeButton({super.key, required this.onComplete});

  @override
  State<SwipeButton> createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<SwipeButton> with SingleTickerProviderStateMixin {
  double _dragPosition = 0.0;
  bool _isCompleted = false;
  
  late AnimationController _springController;
  late Animation<double> _springAnimation;
  
  // Define layout constants
  final double _buttonHeight = 65.0;
  final double _knobSize = 55.0;
  final double _padding = 5.0;
  
  @override
  void initState() {
    super.initState();
    _springController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _springController.addListener(() {
      setState(() {
        _dragPosition = _springAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _springController.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details, double maxWidth) {
    if (_isCompleted) return;

    setState(() {
      _dragPosition += details.delta.dx;
      
      final double maxDragPosition = maxWidth - _knobSize - (_padding * 2);
      if (_dragPosition < 0) {
        _dragPosition = 0;
      } else if (_dragPosition > maxDragPosition) {
        _dragPosition = maxDragPosition;
      }
    });
  }

  void _onPanEnd(DragEndDetails details, double maxWidth) {
    if (_isCompleted) return;

    final double maxDragPosition = maxWidth - _knobSize - (_padding * 2);

    if (_dragPosition >= maxDragPosition * 0.95) {
      setState(() {
        _dragPosition = maxDragPosition;
        _isCompleted = true;
      });
      HapticFeedback.heavyImpact();
      widget.onComplete();
    } else {
      HapticFeedback.lightImpact();
      _springAnimation = Tween<double>(begin: _dragPosition, end: 0.0).animate(
        CurvedAnimation(
          parent: _springController,
          curve: Curves.elasticOut,
        ),
      );
      _springController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double containerWidth = constraints.maxWidth;
        final double maxDragPosition = containerWidth - _knobSize - (_padding * 2);
        
        final double dragRatio = maxDragPosition > 0 ? (_dragPosition / maxDragPosition) : 0.0;
        final double clampedDragRatio = dragRatio.clamp(0.0, 1.0);
        
        // 4 sine waves as you slide, scaling wobble intensity by 4 pixels. Smoothly goes to 0 when completed.
        final double wobble = _isCompleted ? 0.0 : math.sin(clampedDragRatio * math.pi * 8) * 3;
        final double currentHeight = _buttonHeight + wobble;
        
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: math.max(_buttonHeight, containerWidth - _dragPosition),
            height: currentHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(currentHeight / 2),
              color: const Color(0xFFFFC502), // Primary Brand Yellow
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Stack(
              children: [

                // Text in center (wrapped to avoid overflow when shrinking)
                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    child: Container(
                      width: containerWidth - (_padding * 2), // Fixed visual width to keep text centered relative to original size
                      alignment: Alignment.center,
                      child: Text(
                        "Swipe To Continue",
                        style: TextStyle(
                          color: const Color(0xFF2D2D2D).withOpacity((1.0 - clampedDragRatio).clamp(0.0, 1.0)),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Draggable Knob (fixed to the left of the shrinking container)
                Positioned(
                  left: _padding,
                  top: _padding + (wobble / 2), 
                  bottom: _padding + (wobble / 2),
                  child: GestureDetector(
                    onPanUpdate: (details) => _onPanUpdate(details, containerWidth),
                    onPanEnd: (details) => _onPanEnd(details, containerWidth),
                    child: Container(
                      width: _knobSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE8AD00), // Slightly darker yellow knob
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: const Color(0xFF2D2D2D), // Dark slate icon
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
