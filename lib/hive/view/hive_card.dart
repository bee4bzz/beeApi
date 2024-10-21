import 'package:beeapp/hive/widgets/widgets.dart';
import 'package:beeapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class HiveCard extends StatelessWidget {
  const HiveCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          HiveCardHeader(),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomTemperatureText(
                value: 10,
                child: Transform.translate(
                    offset: const Offset(5, -6),
                    child: const Text(
                      "Température\nextérieure",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(alignment: Alignment.centerLeft, child: VisitButton())
        ],
      ),
    );
  }
}

class HiveCardHeader extends StatelessWidget {
  const HiveCardHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        TypeCircularIconButton(),
        SizedBox(width: 10),
        Header(),
        Spacer(),
        NotificationCircularIconButton(),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Ruche 1',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        ConnectionIndicator()
      ],
    );
  }
}

class TypeCircularIconButton extends StatelessWidget {
  const TypeCircularIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircularIconButton(
      icon: LineIcon.hornbill(
        size: 30,
        color: Colors.white,
      ),
    );
  }
}

class ConnectionIndicator extends StatelessWidget {
  const ConnectionIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Colors.white;
    var text = 'Connecté';
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            color: color,
            height: 1.2,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
