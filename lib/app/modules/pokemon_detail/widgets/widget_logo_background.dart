part of '../pokemon_detail_page.dart';

// An isolated StatefulWidget shouldn't significantly impact performance.
class WidgetLogoBackground extends StatefulWidget {
  const WidgetLogoBackground({super.key});

  @override
  WidgetLogoBackgroundState createState() => WidgetLogoBackgroundState();
}

class WidgetLogoBackgroundState extends State<WidgetLogoBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          // 2 * pi = full circle
          angle: _controller.value * 2 * pi,
          child: Image.asset(
            'assets/images/pokeball.png',
            color: Colors.white24,
            width: 250,
            height: 250,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
