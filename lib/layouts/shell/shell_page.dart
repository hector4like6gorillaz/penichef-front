import 'package:base_app/layouts/shell/shell_interactor.dart';
import 'package:base_app/layouts/shell/shell_ui.dart';
import 'package:flutter/material.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({super.key, required this.children});
  final Widget children;

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage>
    implements ShellInteractor {
  @override
  Widget build(BuildContext context) {
    return ShellUI(
      children: widget.children,
    );
  }
}
