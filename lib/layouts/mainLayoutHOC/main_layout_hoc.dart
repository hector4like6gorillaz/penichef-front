//import 'package:base_app/components/navigationBar/navigation_bar.dart';
import 'package:base_app/utils/constans.dart';
import 'package:flutter/material.dart';

class MainLayoutHOC extends StatelessWidget {
  const MainLayoutHOC({
    super.key,
    this.title = "Vacio",
    required this.children,
    this.showAppbar = false,
    this.showBottombar = false,
    this.back = false,
  });
  final String title;
  final Widget children;
  final bool showAppbar;
  final bool showBottombar;
  final bool back;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: showAppbar
              ? AppBar(
                  automaticallyImplyLeading: back,
                  backgroundColor: boneColor,
                  title: Text(title),
                )
              : null,
          body: children,
        ),
      ],
    );
  }
}
