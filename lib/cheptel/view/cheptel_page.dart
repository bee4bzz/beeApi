import 'package:beeapp/cheptel/widgets/widgets.dart';
import 'package:beeapp/hive/view/hive_card.dart';
import 'package:flutter/material.dart';

class CheptelPage extends StatelessWidget {
  const CheptelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CheptelHeader(),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromARGB(255, 192, 138, 48),
                const Color.fromARGB(255, 192, 138, 48),
                const Color.fromARGB(255, 192, 138, 48),
                const Color.fromARGB(255, 255, 228, 182),
              ],
            ),
          ),
          child: SafeArea(
            child: Stack(children: [
              CheptelCardsCollection(),
            ]),
          ),
        ));
  }
}

class CheptelCardsCollection extends StatelessWidget {
  const CheptelCardsCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Mes\nRuches',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Image.asset(
                    'assets/honey_icon.png',
                    fit: BoxFit.contain,
                    width: 75,
                    height: 75,
                  ),
                ],
              )),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: RefreshIndicator(
            color: Colors.black,
            onRefresh: () async {},
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      HiveCard(),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
