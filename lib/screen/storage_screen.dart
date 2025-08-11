import 'package:flutter/material.dart';
import 'package:pif_frontend/bar/pif_appbar.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43),
        child: PifAppbar(
          titlename: '기억의 서랍',
          isMenu: true,
          isBack: false,
          isColored: Color(0xFFA0E4E7),
        ),
      ),
    );
  }
}
