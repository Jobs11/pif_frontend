import 'package:flutter/material.dart';

class PifAppbar extends StatelessWidget {
  final String titlename;
  final bool isMenu, isBack;
  final Color isColored;
  final VoidCallback? onMenuPressed;

  const PifAppbar({
    super.key,
    required this.titlename,
    required this.isMenu,
    required this.isBack,
    required this.isColored,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isColored,
      centerTitle: true,
      automaticallyImplyLeading: isBack,
      actions: [
        Visibility(
          visible: isMenu,
          child: IconButton(
            icon: Image.asset(
              'assets/images/addicon/menu.png',
              width: 21,
              height: 21,
            ),
            onPressed: onMenuPressed,
          ),
        ),
        SizedBox(width: 10),
      ],
      title: Text(
        titlename,
        style: TextStyle(
          fontSize: 32,
          color: Color(0xFF146467),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
