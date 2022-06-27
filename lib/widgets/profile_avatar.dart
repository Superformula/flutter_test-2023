import 'package:flutter/material.dart';
import 'package:restaurantour/theme/app_color.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  const ProfileAvatar({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl.isNotEmpty
        ? CircleAvatar(
            radius: 24.0,
            backgroundImage: NetworkImage(imageUrl),
            backgroundColor: Colors.transparent,
          )
        : CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.dividerLine,
            child: Icon(
              Icons.person,
              color: AppColors.primaryFill,
              size: 32,
            ),
          );
  }
}
