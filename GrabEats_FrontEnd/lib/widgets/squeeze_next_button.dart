import 'package:flutter/material.dart';

class SqueezeNextButton extends StatefulWidget {
  final VoidCallback onNavigate;

  const SqueezeNextButton({super.key, required this.onNavigate});

  @override
  State<SqueezeNextButton> createState() => _SqueezeNextButtonState();
}

class _SqueezeNextButtonState extends State<SqueezeNextButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late Animation<double> _heightAnimation;
  late Animation<double> _offsetAnimation;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    // Initially 60x60. Squeeze to 80x40, then shoot right.
    _widthAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 60, end: 90).chain(CurveTween(curve: Curves.easeOut)), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 90, end: 120).chain(CurveTween(curve: Curves.easeIn)), weight: 50),
    ]).animate(_controller);

    _heightAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 60, end: 40).chain(CurveTween(curve: Curves.easeOut)), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 40, end: 30).chain(CurveTween(curve: Curves.easeIn)), weight: 50),
    ]).animate(_controller);

    // Moves text/icon to the right while squeezing
    _offsetAnimation = Tween<double>(begin: 0, end: 200).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.3, 1.0, curve: Curves.easeInBack)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() async {
    if (_isTapped) return;
    setState(() {
      _isTapped = true;
    });

    _controller.forward();
    
    // Wait for part of the animation, then navigate
    await Future.delayed(const Duration(milliseconds: 400));
    widget.onNavigate();

    // Reset after a delay so it's ready when popping back (if applicable)
    await Future.delayed(const Duration(milliseconds: 400));
    if (mounted) {
      _controller.reset();
      setState(() {
        _isTapped = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color brandYellow = Color(0xFFFFC502);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return InkWell(
          onTap: _handleTap,
          borderRadius: BorderRadius.circular(30),
          child: Transform.translate(
            offset: Offset(_offsetAnimation.value, 0),
            child: Container(
              width: _widthAnimation.value,
              height: _heightAnimation.value,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: brandYellow,
              ),
              alignment: Alignment.center,
              child: _offsetAnimation.value < 100 
                  ? Icon(
                      Icons.arrow_forward_rounded,
                      color: const Color(0xFF2D2D2D),
                      size: 30 * (_heightAnimation.value / 60),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }
}
