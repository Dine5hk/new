import 'package:flutter/material.dart';
import 'package:flutter_application_1/API/userapi.dart';
import 'package:flutter_application_1/dashboard/userform.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<List<User>> users;
  final UserService userService = UserService();

  @override
  void initState() {
    super.initState();
    users = userService.fetchUsers();
  }

  void _navigateToUserForm({User? user}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserForm(user: user),
      ),
    ).then((_) {
      // Refresh the user list after returning from the user form
      setState(() {
        users = userService.fetchUsers();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to the user form to add a new user
              _navigateToUserForm();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final user = snapshot.data![index];
              return ListTile(
                title: Text(user.username), // Corrected to user.username
                subtitle: Text('Mobile: ${user.mobile}'),
                onTap: () {
                  // Navigate to the user form for editing
                  _navigateToUserForm(user: user);
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await userService.deleteUser(user.id);
                    setState(() {
                      users = userService.fetchUsers(); // Refresh user list
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
