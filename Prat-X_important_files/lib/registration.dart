import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:part_time_jobs/login_screen.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController edName = TextEditingController();
  TextEditingController edEmail = TextEditingController();
  TextEditingController edPhone = TextEditingController();
  TextEditingController edPass = TextEditingController();
  TextEditingController edAddress = TextEditingController();
  String message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.app_registration),
            SizedBox(width: 10),
            Text(
              "Registration",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF6C7FFF),
      ),
      backgroundColor: const Color(0xFFFCFAF7),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 1),
              Center(
                child: Icon(
                  Icons.person_add_alt_1,
                  size: 70,
                  color: Color(0xFF6C7FFF),
                ),
              ),
              const SizedBox(height: 1),
              const Center(
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    color: Color(0xFF6C7FFF),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: edName,
                decoration: InputDecoration(
                  hintText: "Full Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: edEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: edPhone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: edPass,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: edAddress,
                decoration: InputDecoration(
                  hintText: "Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      if (edName.text.isEmpty ||
                          edEmail.text.isEmpty ||
                          edPhone.text.isEmpty ||
                          edPass.text.isEmpty) {
                        setState(() {
                          message = "Please fill all required fields!";
                        });
                        return;
                      }

                      try {
                        final email = edEmail.text.trim().toLowerCase();
                        final usersRef = FirebaseDatabase.instance.ref("users");

                        // Modified query with error handling
                        final snapshot = await usersRef
                            .orderByChild('email')
                            .equalTo(email)
                            .once();

                        if (snapshot.snapshot.value != null) {
                          setState(() {
                            message = "Email already registered!";
                          });
                          return;
                        }
                        // Create new user with lowercase email
                        usersRef.push().set({
                          "name": edName.text,
                          "email": email,
                          "phone": edPhone.text,
                          "password": edPass.text,
                          "address": edAddress.text,
                        }).then((_) {
                          setState(() {
                            message = "Registration successful! Welcome ${edName.text}";
                          });
                        });

                      } catch (e) {
                        setState(() {
                          message = "Error: ${e.toString()}";
                        });
                      }
                    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C7FFF),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (message.isNotEmpty)
                Center(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: message.contains("successful")
                          ? Colors.green
                          : Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    "Already have an account? Login",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}