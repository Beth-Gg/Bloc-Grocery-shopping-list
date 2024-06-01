import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Application/bloc/shop_bloc/shop_bloc.dart';
import '../Application/bloc/shop_bloc/shop_state.dart';
import '../Application/bloc/shop_bloc/shop_event.dart';

class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopBloc()..add(LoadShops()),
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ShopLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is ShopLoaded) {
            return Column(
              children: [
                Container(
                  height: 300,
                  child: ListView.builder(
                    itemCount: state.shops.length,
                    itemBuilder: (context, index) {
                      final shop = state.shops[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Text(shop.name.toString()),
                              Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Items in ${shop.name}'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: shop.items?.map<Widget>(
                                            (item) {
                                              return Text(item);
                                            },
                                          )?.toList() ?? [],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text('View Shop'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          if (state is ShopError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return Container();
        },
      ),
    );
  }
}
