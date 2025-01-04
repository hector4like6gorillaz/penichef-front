import 'package:base_app/components/navigationBar/navigation_bar.dart';
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
      children: Row(
        children: [
          Container(
            width: 250,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.red
                      .withOpacity(0.2), // Color de la sombra con opacidad
                  offset: const Offset(10, 0), // Desplazamiento: (x, y)
                  blurRadius: 10, // Difuminado de la sombra
                ),
              ],
            ),
            child: const LeftNavBar(),
          ),
          Expanded(
              child: Container(
            child: children,
          ))
        ],
      ),
    );
  }
}
