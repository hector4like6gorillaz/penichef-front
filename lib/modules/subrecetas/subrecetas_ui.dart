import 'package:base_app/components/button/buttom.dart';
import 'package:base_app/layouts/mainLayoutHOC/main_layout_hoc.dart';
import 'package:base_app/modules/inventary/components/table_inventary.dart';
import 'package:base_app/modules/subrecetas/bloc/subrecetas_bloc.dart';
import 'package:base_app/modules/subrecetas/components/table_subrecetas.dart';
import 'package:base_app/modules/subrecetas/subrecetas_interactor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SubrecetasUi extends StatelessWidget {
  const SubrecetasUi({
    super.key,
    required this.interactor,
  });
  final SubrecetasInteractor interactor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubrecetasBloc, SubrecetasState>(
      builder: (context, state) {
        return MainLayoutHOC(
          showAppbar: true,
          title: "Subrecetas",
          children: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 32, top: 32),
                      child: Row(
                        children: [
                          Button(
                            fn: () {
                              context.pushNamed("addSubrecetaPage");
                            },
                            text: "Agregar subreceta",
                          )
                        ],
                      ),
                    ),
                    if (state.subrecetasData != null)
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              style: BorderStyle.solid,
                            )),
                        margin: const EdgeInsets.all(32),
                        child: TableSubrecetas(
                          data: state.subrecetasData!,
                          interactor: interactor,
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
