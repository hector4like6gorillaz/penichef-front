import 'package:base_app/layouts/shell/shell_page.dart';
import 'package:base_app/modules/home/bloc/home_bloc.dart';
import 'package:base_app/modules/home/home_page.dart';
import 'package:base_app/modules/home/subModules/bloc/operaciones_bloc.dart';
import 'package:base_app/modules/home/subModules/operaciones/operaciones_page.dart';
import 'package:base_app/modules/inventary/bloc/inventary_bloc.dart';
import 'package:base_app/modules/inventary/inventary_page.dart';
import 'package:base_app/modules/inventary/subModules/addToInventary/add_inventary_page.dart';
import 'package:base_app/modules/subrecetas/bloc/subrecetas_bloc.dart';
import 'package:base_app/modules/subrecetas/submodules/createSubreceta/create_subreceta_page.dart';
import 'package:base_app/modules/subrecetas/subrecetas_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  //initialLocation: '/splash',
  initialLocation: '/',
  routes: [
    /*
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
     */
    //rutas principales dentro de un shell para barras de navegacion
    ShellRoute(
        builder: (context, state, child) {
          return ShellPage(
            children: child,
          );
        },
        routes: [
          GoRoute(
              path: '/',
              name: 'homePage',
              builder: (context, state) {
                return BlocProvider(
                  create: (context) => HomeBloc(),
                  child: const HomePage(),
                );
              }),
          GoRoute(
              path: '/inventary',
              name: 'inventaryPage',
              builder: (context, state) {
                return BlocProvider(
                  create: (context) => InventaryBloc(),
                  child: const InventaryPage(),
                );
              }),
          GoRoute(
              path: '/subrecetas',
              name: 'subrecetasPage',
              builder: (context, state) {
                return BlocProvider(
                  create: (context) => SubrecetasBloc(),
                  child: const SubrecetasPage(),
                );
              }),
        ]),

    //rutas secundarias can.pop()
    GoRoute(
        path: '/operations',
        name: 'operationsPage',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => OperacionesBloc(),
            child: const OperacionesPage(),
          );
        }),
    //estas son de inventario
    GoRoute(
        path: '/addInventory',
        name: 'addInventoryPage',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => InventaryBloc(),
            child: const AddInventaryPage(),
          );
        }),
    //estas son de subrecetas
    GoRoute(
        path: '/addSubreceta',
        name: 'addSubrecetaPage',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => SubrecetasBloc(),
            child: const CreateSubrecetaPage(),
          );
        }),
  ],
);
