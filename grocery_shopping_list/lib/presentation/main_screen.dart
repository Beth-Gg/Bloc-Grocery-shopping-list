import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup/presentation/List_page.dart';
// import 'bottom_navigation_cubit.dart';
import 'shop_page.dart';
import 'List_page.dart';
import '../Application/bloc/BottomNav/bottom_navigation_cubit.dart';
import './login_page.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> _pages = [
    ShopPage(),
    GroceryListWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavigationCubit(),
      child: Scaffold(
        body: BlocBuilder<BottomNavigationCubit, int>(
          builder: (context, state) {
            return _pages[state];
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('Shemeta App'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
                        (route) => false, 
                      );                },
                icon: Icon(Icons.logout))
          ],
        ),
        bottomNavigationBar: BlocBuilder<BottomNavigationCubit, int>(
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: state,
              onTap: (currentindex) =>
                  context.read<BottomNavigationCubit>().setPage(currentindex),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.shop),
                  label: 'Shops',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Lists',
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
      (route) => false, 
    );
  }  
}
