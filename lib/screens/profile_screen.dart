import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/auth_notifier.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Mengambil data user yang sedang login
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD), // Warna background agar mirip gambar
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user?.email ?? 'Unknown User'}',
                style: const TextStyle(fontSize: 18)),
            SizedBox(height: screenWidth * 0.05),
            OutlinedButton(
              onPressed: () {
                context.read<AuthNotifier>().signOut();
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                side: BorderSide(color: Colors.grey.shade300),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                backgroundColor: const Color(0xFFF7F5FA), // Warna tombol pudar
              ),
              child: const Text(
                'Logout', 
                style: TextStyle(color: Color(0xFF6750A4)), // Warna teks ungu khas Material 3
              ),
            ),
          ],
        ),
      ),
    );
  }
}
