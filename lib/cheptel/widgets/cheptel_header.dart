part of 'widgets.dart';

class CheptelHeader extends StatelessWidget implements PreferredSizeWidget {
  const CheptelHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // No default "Back" button
      elevation: 0,
      backgroundColor: Colors.transparent, // Transparent AppBar
      flexibleSpace: Column(
        mainAxisAlignment:
            MainAxisAlignment.end, // To position elements at the bottom
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                cheptelTitle(),
                const Spacer(),
                cheptelActions(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cheptelTitle() {
    return const BlurContainer(
      radius: 30,
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: CheptelTitleWithIcon(),
      ),
    );
  }

  Widget cheptelActions() {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SettingsCircularIconButton(),
        SizedBox(width: 5),
        NotificationCircularIconButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(85);
}

class CheptelTitleWithIcon extends StatelessWidget {
  const CheptelTitleWithIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 20),
        Text(
          'cheptel',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(width: 20),
        AddCircularIconButton()
      ],
    );
  }
}
