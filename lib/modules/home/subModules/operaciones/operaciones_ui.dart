import 'package:base_app/components/autoScrollText/auto_scroll_text.dart';
import 'package:base_app/layouts/mainLayoutHOC/main_layout_hoc.dart';
import 'package:base_app/modules/home/subModules/bloc/operaciones_bloc.dart';
import 'package:base_app/utils/constans.dart';
import 'package:base_app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OperacionesUi extends StatelessWidget {
  const OperacionesUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OperacionesBloc, OperacionesState>(
      builder: (context, state) {
        return MainLayoutHOC(
          showAppbar: true,
          back: true,
          title: "Saludos",
          children: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                AutoScrollText(
                  text:
                      "Esto es un ejemplo de mensaje de texto largo no mas para no olvidar este componente",
                  style: TextStyle(fontSize: 30.sp),
                ),
                const Text("presiona <- para regresar")
              ],
            ),
          ),
        );
      },
    );
  }
}
