import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

      leading: (isBack == false)
          ? Visibility(
              visible: isMenu,
              child: IconButton(
                icon: Image.asset(
                  'assets/images/addicon/menu.png',
                  width: 21.w,
                  height: 21.h,
                ),
                onPressed: onMenuPressed,
              ),
            )
          : null,

      title: Text(
        titlename,
        style: TextStyle(
          fontSize: 32.sp,
          color: Color(0xFF146467),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
