import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard/dashbord.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Demo",
              style: TextStyle(
                  color: Colors.blue[500],
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold)),
          Text(
            "Login To the Page",
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),

          // Register Number Field
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              hintText: "Register Number",
              prefixIcon: Icon(Icons.phone),
            ),
          ),

          SizedBox(height: 10.0),

          // Password Field
          TextField(
            obscureText: true, // Mask the password input
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              hintText: "Password",
              prefixIcon: Icon(Icons.lock),
            ),
          ),

          SizedBox(height: 1.0),

          TextButton(
            onPressed: () {},
            child: Text('Forgot Password?'),
          ),

          SizedBox(height: 20.0), // Space between fields and button

          // Login Button (InkWell)
          Center(
            child: InkWell(
              onTap: () {
                // Navigate to dashboard after login
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: 40.0,
                width: 200.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
