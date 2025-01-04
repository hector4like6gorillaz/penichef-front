import 'package:base_app/components/navigationBar/on_hover_option.dart';
import 'package:base_app/utils/constans.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LeftNavBar extends StatefulWidget {
  const LeftNavBar({super.key});

  @override
  State<LeftNavBar> createState() => _LeftNavBarState();
}

class _LeftNavBarState extends State<LeftNavBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: widthLeftBar,
          height: widthLeftBar,
          child: Image.asset(
            "assets/logo.jpeg",
            fit: BoxFit.cover,
          ),
        ),
        HoverOptionMenu(
          fn: () {
            context.goNamed('inventaryPage');
          },
          text: "Inventario",
          icon: Icons.inventory_rounded,
        ),
        HoverOptionMenu(
          fn: () {
            context.goNamed('subrecetasPage');
          },
          text: "SubRecetas",
          icon: Icons.receipt,
        ),
      ],
    );
  }
}
