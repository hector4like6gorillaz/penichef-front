import 'package:flutter/material.dart';

class ModalHOC extends StatelessWidget {
  const ModalHOC({
    super.key,
    required this.children,
    required this.close,
    this.disableBackClick = false,
  });
  final List<Widget> children;
  final Function close;
  final bool disableBackClick;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
                child: GestureDetector(
              onTap: () => disableBackClick && close(),
              child: Container(
                color: const Color.fromRGBO(0, 0, 0, 0.5),
              ),
            )),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: children,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () => close(),
                                icon: const Icon(Icons.close))
                          ],
                        ))
                  ],
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
