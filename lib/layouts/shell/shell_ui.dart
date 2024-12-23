import 'package:base_app/layouts/mainLayoutHOC/main_layout_hoc.dart';
import 'package:flutter/material.dart';

class ShellUI extends StatelessWidget {
  const ShellUI({
    super.key,
    required this.children,
  });
  final Widget children;

  @override
  Widget build(BuildContext context) {
    return MainLayoutHOC(
      showAppbar: false,
      showBottombar: true,
      children: children,

    );
  }
}
