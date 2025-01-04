import 'package:base_app/utils/constans.dart';
import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  const InputText({
    super.key,
    required this.handle,
    this.validador = "ingresa un valor",
    this.hintText = "place holder",
    this.topLabelText,
    this.type = TextInputType.text,
    this.initialValue = "",
  });
  final Function(String value) handle;
  final String validador;
  final String hintText;
  final String? topLabelText;
  final TextInputType type;
  final String initialValue;

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  bool _showValidator = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            if (widget.topLabelText != null)
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.topLabelText!,
                        style: textSmallStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _showValidator ? Colors.red : Colors.grey,
                    style: BorderStyle.solid,
                  )),
              child: TextFormField(
                initialValue: widget.initialValue,
                keyboardType: widget.type,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                onChanged: (value) => widget.handle(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      _showValidator = true;
                    });
                  } else {
                    setState(() {
                      _showValidator = false;
                    });
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        if (_showValidator)
          Positioned(
            bottom: 0,
            left: 24,
            child: Text(
              widget.validador,
              style: textErrorStyle,
            ),
          )
      ],
    );
  }
}
