import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.black12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _scope,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 16),
          style: const TextStyle(fontSize: 12, color: Colors.black87),
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
