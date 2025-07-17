import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Image.asset('assets/images/logo.webp', height: 40));
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}
