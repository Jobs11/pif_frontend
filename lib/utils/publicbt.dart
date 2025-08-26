import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VisibilityScopeChip extends StatefulWidget {
  final String initial;
  final ValueChanged<String>? onChanged;
  const VisibilityScopeChip({super.key, this.initial = '공개', this.onChanged});

  @override
  State<VisibilityScopeChip> createState() => _VisibilityScopeChipState();
}

class _VisibilityScopeChipState extends State<VisibilityScopeChip> {
  late String _scope;

  @override
  void initState() {
    super.initState();
    _scope = widget.initial; // '공개' | '친구만' | '비공개'
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: Colors.black12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _scope,
          isDense: true,
          icon: Icon(Icons.keyboard_arrow_down, size: 16.sp),
          style: TextStyle(fontSize: 12.sp, color: Colors.black87),
          items: const [
            DropdownMenuItem(value: '공개', child: Text('공개')),
            DropdownMenuItem(value: '비공개', child: Text('비공개')),
          ],
          onChanged: (v) {
            if (v == null) return;
            setState(() => _scope = v);
            widget.onChanged?.call(v);
          },
        ),
      ),
    );
  }
}
