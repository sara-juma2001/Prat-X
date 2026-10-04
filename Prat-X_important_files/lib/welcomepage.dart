import 'package:flutter/material.dart';
import 'package:part_time_jobs/login_screen.dart';

class welcome extends StatefulWidget {
  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: const Color(0xFF6C7FFF),
        elevation: 0,
      ),

      body: Center(
        child: Padding(
          padding:EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Part Time Jobs',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Arial',
                ),

              ),
              SizedBox(height: 20),
                  Image.asset(
                    'assets/welcom_s.png',
                    width: 400,
                    height: 300,
                    fit: BoxFit.fitHeight,
                  ),

              SizedBox(height: 20),
              Text(
                'Provide flexible work opportunities for students and individuals',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'Arial',
                ),
                textAlign: TextAlign.center,
              ), SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                icon: const Icon(Icons.work, color: Colors.white),
                label: const Text(
                  'Try Now',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Arial',
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C7FFF),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFDCE7F2),
    );
  }
}

