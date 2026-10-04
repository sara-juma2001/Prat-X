import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:part_time_jobs/adminpage.dart';
import 'package:part_time_jobs/homepage.dart';
import 'package:part_time_jobs/registration.dart';
import 'package:part_time_jobs/global.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dbRef = FirebaseDatabase.instance.ref('users');
  bool _isLoading = false;

  TextEditingController edEmail = TextEditingController();
  TextEditingController edPass = TextEditingController();

  void _signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      try {
        final email = edEmail.text.trim().toLowerCase();
        final password = edPass.text.trim();

        // Query using indexed email field
        final query = _dbRef.orderByChild('email').equalTo(email);
        final snapshot = await query.get();

        if (!snapshot.exists) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user found with this email')),
          );
          return;
        }

        final userData = snapshot.value as Map<dynamic, dynamic>;
        final userEntry = userData.entries.firstWhere(
              (entry) => entry.value['password'] == password,
          orElse: () => const MapEntry(null, null),
        );

        if (userEntry.key != null && mounted) {
          globals.currentUserId = userEntry.key.toString();
          globals.userName = userEntry.value['name'] ?? "";
          globals.userEmail = userEntry.value['email'] ?? "";
          globals.userPhone = userEntry.value['phone'] ?? "";
          globals.userAddress = userEntry.value['address'] ?? "";

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => email == "admin"
                  ? const AdminPage()
                  : const HomePage(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid password')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.login, color: Colors.white),
            SizedBox(width: 10),
            Text(
              "Login",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF6C7FFF),
      ),
      backgroundColor: const Color(0xFFFCFAF7),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Icon(
                  Icons.work_outline,
                  size: 100,
                  color: Color(0xFF6C7FFF),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Login to Continue",
                  style: TextStyle(
                    color: Color(0xFF6C7FFF),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: edEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? 'Please enter email' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: edPass,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) => value?.isEmpty ?? true ? 'Please enter password' : null,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _isLoading ? null : _signIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C7FFF),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Registration()),
                  ),
                  child: const Text(
                    "Don't have an account? Register here",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6C7FFF),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}