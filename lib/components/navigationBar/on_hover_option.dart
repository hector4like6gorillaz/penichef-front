import 'package:base_app/utils/constans.dart';
import 'package:flutter/material.dart';

class HoverOptionMenu extends StatefulWidget {
  const HoverOptionMenu({
    super.key,
    required this.fn,
    this.text = "Vacio",
    this.icon = Icons.abc,
  });

  final Function fn;
  final String text;
  final IconData icon;

  @override
  State<HoverOptionMenu> createState() => _HoverOptionMenuState();
}

class _HoverOptionMenuState extends State<HoverOptionMenu> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        disabledColor: Colors.grey,
        onPressed: () {
          widget.fn();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          height: 50,
          color: _isHovered
              ? primaryColor
              : secondaryColor, // Cambia la propiedad según el estado
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 30,
              ),
              const SizedBox(width: 20),
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 20,
                  color: _isHovered
                      ? Colors.white
                      : Colors.black, // Cambia el color del texto en hover
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
