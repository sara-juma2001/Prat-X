import 'package:flutter/material.dart';
import 'package:part_time_jobs/global.dart';
import 'package:part_time_jobs/job_listings.dart';


class JobDetailsScreen extends StatefulWidget {
  final Job job;

  const JobDetailsScreen({super.key, required this.job});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool isApplied = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C7FFF),
        elevation: 0,
        title: Text(
          widget.job.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Main Job Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.job.company,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C7FFF),
                            ),
                          ),
                          Chip(
                            label: Text(widget.job.type),
                            backgroundColor: const Color(0xCAD9FFFF),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      _buildDetailRow(Icons.location_on, widget.job.location),
                      const SizedBox(height: 10),
                      _buildDetailRow(Icons.attach_money, widget.job.salary),
                      const SizedBox(height: 10),
                      _buildDetailRow(Icons.schedule, "Immediate Start"),
                      const SizedBox(height: 20),
                      Text(
                        "Posted 2 days ago",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Job Description Card
              _buildSectionCard(
                title: "Job Description",
                content: "We're looking for a motivated individual to join our team. Responsibilities include:\n\n• Customer service\n• Stock management\n• Sales operations\n• Maintaining store cleanliness",
              ),

              const SizedBox(height: 20),

              // Requirements Card
              _buildSectionCard(
                title: "Requirements",
                content: "• High school diploma\n• Retail experience preferred\n• Good communication skills\n• Flexible schedule\n• Team player attitude",
              ),

              const SizedBox(height: 20),

              // Benefits Card
              _buildSectionCard(
                title: "Benefits",
                content: "• Competitive salary\n• Employee discounts\n• Training programs\n• Career growth opportunities\n• Friendly work environment",
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            isApplied = !isApplied;
          });
        },
        icon: Icon(isApplied ? Icons.check : Icons.send),
        label: Text(isApplied ? "Applied" : "Apply Now"),
        backgroundColor: isApplied ? Colors.grey : const Color(0xFF6C7FFF),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildSectionCard({required String title, required String content}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6C7FFF),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}