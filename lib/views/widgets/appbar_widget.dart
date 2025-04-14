import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool transparentBackground;
  const AppbarWidget({
    super.key,
    required this.title,
    this.transparentBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: transparentBackground ? Colors.transparent : null,
      title: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
