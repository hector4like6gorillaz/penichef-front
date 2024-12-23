import 'package:flutter/material.dart';

class AutoScrollText extends StatefulWidget {
  const AutoScrollText({
    super.key,
    required this.text,
    this.durationSeconds = 5,
    this.style,
  });
  final String text;
  final int durationSeconds;
  final TextStyle? style;

  @override
  State<AutoScrollText> createState() => _AutoScrollTextState();
}

class _AutoScrollTextState extends State<AutoScrollText>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: widget.durationSeconds,
      ), // Duración del scroll completo
    );

    // Configura la animación y añade el listener
    _animationController.addListener(() {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_animation.value);
      }
    });

    // Inicia la animación después de 2 segundos al inicio
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2)); // Delay inicial
      _startScrolling();
    });
  }

  Future<void> _startScrolling() async {
    if (_scrollController.hasClients) {
      // Configura la animación para que vaya del principio al final del scroll
      _animation = Tween<double>(
        begin: 0,
        end: _scrollController.position.maxScrollExtent, // Final del scroll
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ));

      while (mounted) {
        // Desplazarse hasta el final
        await _animationController.forward();

        // Esperar 1 segundo al llegar al final
        await Future.delayed(const Duration(seconds: 1));

        // Saltar de inmediato al inicio
        _scrollController.jumpTo(0);

        // Esperar 2 segundos al llegar al inicio
        await Future.delayed(const Duration(seconds: 2));

        // Reiniciar la animación
        _animationController.reset();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text(
            widget.text,
            style: widget.style,
          ),
        ],
      ),
    );
  }
}
