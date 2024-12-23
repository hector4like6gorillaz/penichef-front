import 'package:base_app/components/button/buttom.dart';
import 'package:base_app/layouts/mainLayoutHOC/main_layout_hoc.dart';
import 'package:base_app/modules/home/bloc/home_bloc.dart';
import 'package:base_app/modules/home/home_interactor.dart';
import 'package:base_app/utils/constans.dart';
import 'package:base_app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeUi extends StatelessWidget {
  const HomeUi({
    super.key,
    required this.interactor,
  });
  final HomeInteractor interactor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return MainLayoutHOC(
          showAppbar: true,
          title: "Soy el home",
          children: RefreshIndicator(
            onRefresh: () async {
              interactor.getPokemonById(151);
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.sp,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Elige la operacion a realizar"),
                    ],
                  ),
                  Button(
                    text: "Suma",
                    fn: () {
                      interactor.getOperation("+");
                      interactor.getPokemonById(state.numero + 1);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Button(
                    text: "Resta",
                    fn: () {
                      interactor.getOperation("-");
                      interactor.getPokemonById(state.numero - 1);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Button(
                    text: "Mostrar saludo",
                    fn: () {
                      context.pushNamed("operationsPage"
                          /*
                      , extra: {
                        "route": state.routesOnMapSearch[index],
                      }
                       */
                          );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("id pokemon: ${state.numero}"),
                  const SizedBox(height: 20),
                  if (state.state == ApiState.loading)
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 5,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  if (state.state == ApiState.success)
                    Column(
                      children: [
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.network(
                            state.picture,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(state.name),
                      ],
                    ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: Image.asset(
                        "assets/selena.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
