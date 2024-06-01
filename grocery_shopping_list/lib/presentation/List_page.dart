import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/Application/bloc/list/list_bloc.dart';
import '/Application/bloc/list/list_state.dart';
import '/Application/bloc/list/list_event.dart';
import '../Infrastructure/repositories/list_repository.dart';
import '../Infrastructure/models/list.dart';

class GroceryListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<GroceryListBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery Lists'),
      ),
      body: BlocBuilder<GroceryListBloc, GroceryListState>(
        builder: (context, state) {
          if (state is GroceryListLoaded) {
            return ListView.builder(
              itemCount: state.lists.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.lists[index].date),
                  subtitle: Text(state.lists[index].content),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showEditListDialog(
                              context, bloc, state.lists[index]);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          bloc.add(DeleteListEvent(id: state.lists[index].id));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is GroceryListError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddListDialog(context, bloc);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddListDialog(BuildContext context, GroceryListBloc bloc) {
    final _formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final itemController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add List'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: itemController,
                  decoration: InputDecoration(labelText: 'Item'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an item';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  bloc.add(AddAddListEvent(
                    date: titleController.text,
                    content: itemController.text,
                  ));
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditListDialog(
      BuildContext context, GroceryListBloc bloc, GroceryList list) {
    final _formKey = GlobalKey<FormState>();
    final titleController = TextEditingController(text: list.date);
    final itemController = TextEditingController(text: list.content);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit List'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: itemController,
                  decoration: InputDecoration(labelText: 'Item'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an item';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  bloc.add(EditListEvent(
                    id: list.id,
                    date: titleController.text,
                    content: itemController.text,
                  ));
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '/Application/bloc/list/list_bloc.dart';
// import '/Application/bloc/list/list_state.dart';
// import '/Application/bloc/list/list_event.dart';
// import '/Infrastructure/models/list.dart';

// class GroceryListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => GroceryListBloc(
//         listRepository: ListRepository(),
//       ),
//       child: GroceryListWidget(),
//     );
//   }
// }

// class GroceryListWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
    

//     final bloc = BlocProvider.of<GroceryListBloc>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Grocery Lists'),
//       ),
//       body: BlocBuilder<GroceryListBloc, GroceryListState>(
//         builder: (context, state) {
//           if (state is GroceryListLoaded) {
//             return ListView.builder(
//               itemCount: state.lists.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(state.lists[index].date),
//                   subtitle: Text(state.lists[index].content),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.edit),
//                         onPressed: () {
//                           _showEditListDialog(
//                               context, bloc, state.lists[index]);
//                         },
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.delete),
//                         onPressed: () {
//                           bloc.add(DeleteListEvent(id: state.lists[index].id));
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           } else if (state is GroceryListError) {
//             return Center(child: Text(state.message));
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showAddListDialog(context, bloc);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   void _showAddListDialog(BuildContext context, GroceryListBloc bloc) {
//     final _formKey = GlobalKey<FormState>();
//     final titleController = TextEditingController();
//     final itemController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add List'),
//           content: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   controller: titleController,
//                   decoration: InputDecoration(labelText: 'Title'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a title';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: itemController,
//                   decoration: InputDecoration(labelText: 'Item'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter an item';
//                     }
//                     return null;
//                   },
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             TextButton(
//               child: Text('Add'),
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   bloc.add(AddAddListEvent(
//                     date: titleController.text,
//                     content: itemController.text,
//                   ));
//                   Navigator.pop(context);
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showEditListDialog(
//       BuildContext context, GroceryListBloc bloc, GroceryList list) {
//     final _formKey = GlobalKey<FormState>();
//     final titleController = TextEditingController(text: list.date);
//     final itemController = TextEditingController(text: list.content);

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Edit List'),
//           content: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   controller: titleController,
//                   decoration: InputDecoration(labelText: 'Title'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a title';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: itemController,
//                   decoration: InputDecoration(labelText: 'Item'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter an item';
//                     }
//                     return null;
//                   },
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             TextButton(
//               child: Text('Save'),
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   bloc.add(EditListEvent(
//                     id: list.id,
//                     date: titleController.text,
//                     content: itemController.text,
//                   ));
//                   Navigator.pop(context);
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


