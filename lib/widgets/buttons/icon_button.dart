part of '../widgets.dart';

class NotificationCircularIconButton extends StatelessWidget {
  final void Function()? onTap;

  const NotificationCircularIconButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CircularIconButton(
      icon: const LineIcon.bell(color: Colors.white),
      onTap: onTap,
    );
  }
}

class SettingsCircularIconButton extends StatelessWidget {
  final void Function()? onTap;

  const SettingsCircularIconButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CircularIconButton(
      icon: const LineIcon.cog(color: Colors.white),
      onTap: onTap,
    );
  }
}

class AddCircularIconButton extends StatelessWidget {
  final void Function()? onTap;

  const AddCircularIconButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CircularIconButton(
      icon: const LineIcon.plus(color: Colors.white),
      onTap: onTap,
    );
  }
}

class CircularIconButton extends StatelessWidget {
  final Widget? icon;
  final void Function()? onTap;

  const CircularIconButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BlurEffect(
        radius: BorderRadius.circular(60),
        child: Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(69),
              shape: BoxShape.circle,
            ),
            child: icon),
      ),
    );
  }
}
