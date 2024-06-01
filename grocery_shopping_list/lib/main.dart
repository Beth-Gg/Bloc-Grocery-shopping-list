// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'Application/bloc/Login/Login_bloc.dart';
// import 'Application/Usecase/login_usecase.dart';
// import '/Presentation/shop_page.dart';
// import 'Infrastructure/api_service.dart';
// import 'presentation/signup_page.dart';
// import 'presentation/login_page.dart';
// import 'package:signup/Infrastructure/repositories/Auth_repository.dart';
// import 'Application/bloc/Login/Login_state.dart';
// import './presentation/main_screen.dart';

// void main() {
//   runApp(
//     MultiBlocProvider(
//       providers: [
//         BlocProvider<AuthBloc>(
//           create: (context) => AuthBloc(apiService: ApiService()),
//         ),
//         BlocProvider<RoleBloc>(
//           create: (context) => RoleBloc(),
//         ),
//       ],
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'BLoC Demo',
//       home: SignUpScreen(),
//       routes: {
//         '/login': (context) => BlocConsumer<AuthBloc, AuthState>(
//           listener: (context, state) {
//             if (state.isLoggedIn) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => MainScreen()),
//               );
//             }
//           },
//           builder: (context, state) {
//             return LoginScreen();
//           },
//         ),
//         '/shops': (context) => ShopPage(),
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup/Application/bloc/list/list_bloc.dart';
import 'package:signup/Application/bloc/shop_bloc/shop_bloc.dart';
import 'package:signup/Infrastructure/repositories/shop_repository.dart';
import 'Application/bloc/Login/Login_bloc.dart';
import 'Infrastructure/api_service.dart';
import 'Application/bloc/Login/Login_state.dart';
import 'Application/bloc/Login/Login_event.dart';
import './presentation/router.dart';
import 'package:signup/Infrastructure/repositories/list_repository.dart';


void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(apiService: ApiService()),
        ),
        BlocProvider<ShopBloc>(
          create: (context) => ShopBloc(),
        ),
        BlocProvider<GroceryListBloc>(
          create: (context) => GroceryListBloc(listRepository: ListRepository()),
        ),
        BlocProvider<GroceryListBloc>(
          create: (context) => GroceryListBloc(listRepository: ListRepository()),
        ),
        
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BLoC Demo',
      routerConfig: router,
    );
  }
}

