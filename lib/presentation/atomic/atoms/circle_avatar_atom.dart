part of 'package.dart';

class CircleAvatarAtom extends StatelessWidget {
  final String? url;
  final double? radius;
  const CircleAvatarAtom({super.key, this.url, this.radius});

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(
          url!,
        ),
      );
    }
    return const CircleAvatar(
      radius: 40,
      child: Icon(Icons.person),
    );
  }
}
