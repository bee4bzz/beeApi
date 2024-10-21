part of 'widgets.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final void Function(BuildContext context)? onTap;

  const CustomCard({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap!(context) : null,
      child: BlurContainer(
        radius: 32,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: child,
        ),
      ),
    );
  }
}

class BlurContainer extends StatelessWidget {
  final Widget child;
  final double radius;

  const BlurContainer({super.key, required this.child, required this.radius});

  @override
  Widget build(BuildContext context) {
    return BlurEffect(
      radius: BorderRadius.circular(radius),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(69),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child,
      ),
    );
  }
}

class BlurEffect extends StatelessWidget {
  final Widget child;
  final BorderRadius? radius;
  final double blur;

  const BlurEffect(
      {super.key, required this.child, this.radius, this.blur = 5.0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius ?? BorderRadius.circular(30.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: child,
      ),
    );
  }
}
