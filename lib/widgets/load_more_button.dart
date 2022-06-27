import 'package:flutter/material.dart';
import 'package:restaurantour/theme/app_color.dart';

// class LoadMoreButton extends StatelessWidget {
//   final VoidCallback onLoadMoreTap;
//   final bool isLoading;
//   const LoadMoreButton({
//     Key? key,
//     required this.onLoadMoreTap,
//     required this.isLoading,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
//       child: isLoading
//           ? Center(
//               child: CircularProgressIndicator(
//                 valueColor:
//                     AlwaysStoppedAnimation<Color>(AppColors.primaryFill),
//               ),
//             )
//           : TextButton(
//               onPressed: onLoadMoreTap,
//               child: Text(
//                 "View More",
//                 style: Theme.of(context).textTheme.button,
//               ),
//             ),
//     );
//   }
// }

class LoadMoreButton extends StatefulWidget {
  final VoidCallback onLoadMoreTap;

  const LoadMoreButton({Key? key, required this.onLoadMoreTap})
      : super(key: key);

  @override
  State<LoadMoreButton> createState() => _LoadMoreButtonState();
}

class _LoadMoreButtonState extends State<LoadMoreButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primaryFill),
              ),
            )
          : TextButton(
              onPressed: () {
                widget.onLoadMoreTap();
                setState(() {
                  _isLoading = true;
                });
              },
              child: Text(
                "View More",
                style: Theme.of(context).textTheme.button,
              ),
            ),
    );
  }
}
