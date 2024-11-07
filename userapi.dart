import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final int id;
  final String username;
  final String email;
  final String mobile;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.mobile});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      mobile: json['mobile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'mobile': mobile,
    };
  }
}

class UserService {
  final String apiUrl =
      'http://103.13.178.21:5000/api/users'; // Change this to your local IP

  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((user) => User.fromJson(user)).toList();
      } else {
        throw Exception('Error fetching users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  Future<User> addUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode == 201) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to add user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding user: $e');
    }
  }

  Future<void> deleteUser(int userId) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$userId'));
      if (response.statusCode != 204) {
        throw Exception('Failed to delete user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }

  Future<User> updateUser(User user) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/${user.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }
}
