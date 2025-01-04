import 'package:flutter/material.dart';

class CenterRowHOC extends StatelessWidget {
  const CenterRowHOC({
    super.key,
    required this.children,
  });
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
