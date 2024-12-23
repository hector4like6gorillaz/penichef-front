import 'package:base_app/utils/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';


class NaviGationBottomBar extends StatefulWidget {
  const NaviGationBottomBar({
    super.key,
    required this.indexNavigation,
  });
  final int indexNavigation;

  @override
  State<NaviGationBottomBar> createState() => _NaviGationBottomBarState();
}

class _NaviGationBottomBarState extends State<NaviGationBottomBar> {
  void _onItemTapped(int index) {
    setState(() {
      /*
      BlocProvider.of<GlobalStatesBloc>(context)
          .add(HandleNavigationIndexEvent(index: index));
       */
    });

    switch (index) {
      case 0:
        context.pushReplacement('/');
        break;
      case 1:
        //context.pushReplacement('/eventos');
        break;
      case 2:
        //context.pushReplacement('/routes');
        break;
      case 3:
        //context.pushReplacement('/companies');
        break;
      case 4:
        //context.pushReplacement('/xmatkuilMap');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double width = (size.width - 40) / 5;
    return Container(
        height: 84,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: splashColorFull,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Color de la sombra
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconMenu(
                    width: width,
                    icon: 'assets/icons/home.svg',
                    selected: widget.indexNavigation == 0,
                    onTaped: () => _onItemTapped(0),
                    text: "Home",
                  ),
                  IconMenu(
                    width: width,
                    icon: 'assets/icons/calendar.svg',
                    selected: widget.indexNavigation == 1,
                    onTaped: () => _onItemTapped(1),
                    text: "Eventos",
                  ),
                  IconMenu(
                    width: width,
                    icon: 'assets/icons/car.svg',
                    selected: widget.indexNavigation == 2,
                    onTaped: () => _onItemTapped(2),
                    text: "Transporte",
                  ),
                  IconMenu(
                    width: width,
                    icon: 'assets/icons/book.svg',
                    selected: widget.indexNavigation == 3,
                    onTaped: () => _onItemTapped(3),
                    text: "Patron",
                  ),
                  IconMenu(
                    width: width,
                    icon: 'assets/icons/map.svg',
                    selected: widget.indexNavigation == 4,
                    onTaped: () => _onItemTapped(4),
                    text: "Mapa",
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class IconMenu extends StatelessWidget {
  const IconMenu({
    super.key,
    required this.width,
    required this.selected,
    required this.onTaped,
    required this.icon,
    this.text = "home",
  });
  final double width;
  final bool selected;
  final Function onTaped;
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTaped(),
      child: Stack(
        children: [
          if (selected)
            Positioned.fill(
                child: Container(
              color: const Color.fromRGBO(154, 29, 79, 1),
            )),
          SizedBox(
              height: 84,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      SvgPicture.asset(
                        icon,
                        
                        color: Colors.white,
                        height: 0.035.sh,
                      ),
                      Text(
                        text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9.sp,
                        ),
                      )
                    ],
                  ),
                ],
              )),
          if (selected)
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      color: selecterMenuTop,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      )),
                  height: 6,
                  width: double.infinity,
                )),
        ],
      ),
    );
  }
}
