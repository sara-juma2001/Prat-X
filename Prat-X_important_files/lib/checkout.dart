
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'job_listings.dart';
import 'package:part_time_jobs/global.dart';

class JobCheckoutPage extends StatelessWidget {
  final Map<String, dynamic> userInfo;
  final Job job;

  const JobCheckoutPage({
    super.key,
    required this.userInfo,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Application Checkout"),
        backgroundColor: const Color(0xFF6C7FFF),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // User Information Card
            Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your Information",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6C7FFF),
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildInfoRow("Full Name", userInfo['Name']),
                    _buildInfoRow("Email", userInfo['Email']),
                    _buildInfoRow("Phone", userInfo['Phone']),
                    _buildInfoRow("Address", userInfo['Address']),
                  ],
                ),
              ),
            ),

            // Job Details Card
            Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Job Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6C7FFF),
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildJobDetailRow("Position", job.title),
                    _buildJobDetailRow("Company", job.company),
                    _buildJobDetailRow("Location", job.location),
                    _buildJobDetailRow("Salary", job.salary),
                    _buildJobDetailRow("Type", job.type),
                  ],
                ),
              ),
            ),

            // Submit Application Button
            Center(
              child: ElevatedButton(
                onPressed: () {
            final userApplicationsRef = FirebaseDatabase.instance.ref('userApplications/${globals.currentUserId}');
            final newApplicationRef = userApplicationsRef.push();

            newApplicationRef.set({
            'jobId': job.id,
            'title': job.title,
            'company': job.company,
            'location': job.location,
            'salary': job.salary,
            'type': job.type,
            'status': 'pending',
            'appliedAt': ServerValue.timestamp,
            'applicationId': newApplicationRef.key,
            }).then((_) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Application submitted successfully!')),
            );
            });
            },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C7FFF),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Confirm Application',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$title:",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$title:",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF6C7FFF),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}