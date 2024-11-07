import 'package:flutter/material.dart';
import 'package:flutter_application_1/API/userapi.dart';

class UserForm extends StatefulWidget {
  final User? user;

  UserForm({Key? key, this.user}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final UserService userService = UserService();

  String username = '';
  String email = '';
  String mobile = '';

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      username = widget.user!.username;
      email = widget.user!.email;
      mobile = widget.user!.mobile;
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      User newUser = User(
        id: widget.user?.id ??
            0, // For adding, id will be 0, which the API will handle
        username: username,
        email: email,
        mobile: mobile,
      );

      try {
        if (widget.user == null) {
          await userService.addUser(newUser);
        } else {
          await userService.updateUser(newUser);
        }
        Navigator.pop(context); // Return to dashboard
      } catch (error) {
        // Handle errors here
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to save user: $error'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Add User' : 'Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: username,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onSaved: (value) {
                  username = value!;
                },
              ),
              TextFormField(
                initialValue: email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value!;
                },
              ),
              TextFormField(
                initialValue: mobile,
                decoration: InputDecoration(labelText: 'Mobile'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a mobile number';
                  }
                  return null;
                },
                onSaved: (value) {
                  mobile = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.user == null ? 'Add User' : 'Update User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
