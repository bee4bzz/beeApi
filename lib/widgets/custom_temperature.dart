part of 'widgets.dart';

class CustomTemperatureText extends StatelessWidget {
  final double? value;
  final Widget? child;
  final int decimalPlaces;
  final String? unit;

  const CustomTemperatureText(
      {super.key,
      required this.value,
      this.child,
      this.decimalPlaces = 1,
      this.unit});

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return RichText(
          text: const TextSpan(
              text: "...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 45.0,
                fontWeight: FontWeight.w400,
              )));
    }
    var integerPart = value?.toInt();
    var decimalPart = ((value! - integerPart!) * 10 * decimalPlaces).toInt();
    return RichText(
      text: TextSpan(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 45.0,
            fontWeight: FontWeight.w400,
          ),
          children: [
            TextSpan(
              text: "$integerPart",
            ),
            const TextSpan(
                text: ".",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  letterSpacing: -2.0,
                )),
            WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
              ),
              child: Stack(
                children: [
                  Transform.translate(
                      offset: const Offset(1, -14),
                      child: const HollowCircle()),
                  Transform.translate(
                      offset: const Offset(0, -1),
                      child: RichText(
                        text: TextSpan(
                            text: '$decimalPart ${unit ?? ""}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              wordSpacing: 3,
                              fontWeight: FontWeight.w300,
                            )),
                      ))
                ],
              ),
            ),
            if (child != null) WidgetSpan(child: child!)
          ]),
    );
  }
}

class HollowCircle extends StatelessWidget {
  const HollowCircle({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9.5, // Taille du cercle
      height: 9.5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white, // Couleur de la bordure
          width: 1.5, // Épaisseur de la bordure
        ),
      ),
    );
  }
}
