// user_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user.dart';
import 'userBloc.dart';
import 'userEvent.dart';

class AddUserDialog extends StatefulWidget {
  final User? user; // User data to pre-fill if editing
  final int? index; // Index of the user being edited, if applicable

  AddUserDialog({
    this.user,
    this.index,
  });

  @override
  _AddUserDialogState createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    // Pre-fill text fields if editing user
    if (widget.user != null) {
      usernameController.text = widget.user!.username;
      locationController.text = widget.user!.location;
      items = List.from(widget.user!.items);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 400,
      width: 400,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              widget.user != null ? 'Edit Shop' : 'Add Shop',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.black,
              ),
            ),
            buildTextField('Username', usernameController),
            buildTextField('Location', locationController),
            Row(
              children: [
                Expanded(
                  child: buildTextField('Item', itemController),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      items.add(itemController.text);
                      itemController.clear();
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(
                            255, 34, 21, 216)), // Set background color
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Set text color
                  ),
                  child: Text('Add Item'),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Items:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '- $item',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final user = User(
                  usernameController.text,
                  locationController.text,
                  items,
                );
                if (widget.user != null && widget.index != null) {
                  // If editing existing user, add EditUser event
                  BlocProvider.of<UserBloc>(context).add(EditUser(widget.index!, user));
                } else {
                  // If adding new user, add AddUser event
                  BlocProvider.of<UserBloc>(context).add(AddUser(user));
                }
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 34, 21, 216)), // Set background color
                foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white), // Set text color
              ),
              child: Text(widget.user != null ? 'Save Changes' : 'Add Shop'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String hint, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.all(4),
      child: TextField(
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
            ),
          ),
        ),
        controller: controller,
      ),
    );
  }
}



