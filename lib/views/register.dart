import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/services/firebase_auth_service.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  void register() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String fullName = _fullNameController.text;
    String nickname = _nicknameController.text;

    // Additional validation or processing can be done here

    User? user = await _authService.SignUpWithEmailandPassword(
        email, password, context);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User is successfully created"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Login()));
      // ini home nya kemana
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cannot create user"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/mobil.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45,BlendMode.darken),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Register",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color.fromRGBO(254, 250, 224, 10),),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: BoxDecoration(
              color: Colors.grey[600]!.withOpacity(0.7),
              borderRadius: BorderRadius.circular(16),
              ),
            child: TextField(
              controller: _fullNameController,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "Nama Panjang",
              ),
            ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Container(
              decoration: BoxDecoration(
              color: Colors.grey[600]!.withOpacity(0.7),
              borderRadius: BorderRadius.circular(16),
              ),
            child: TextField(
              controller: _nicknameController,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                hintText: "Nickname",
              ),
            ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Container(
              decoration: BoxDecoration(
              color: Colors.grey[600]!.withOpacity(0.7),
              borderRadius: BorderRadius.circular(16),
              ),
            child: TextField(
              controller: _emailController,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "Email Address",
              ),
            ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Container(
              decoration: BoxDecoration(
              color: Colors.grey[600]!.withOpacity(0.7),
              borderRadius: BorderRadius.circular(16),
              ),
            child: TextField(
              controller: _passwordController,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.key),
                hintText: "Password",
              ),
              obscureText: true,
            ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:Color.fromRGBO(254, 250, 224, 10),
                  shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  register();
                },
                child: const Text(
                  "Sign up",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already has an account?", style: TextStyle(color: Colors.white),),
                const SizedBox(width: 8.0),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Login()));
                  },
                  child: const Text(
                    "Login.",
                    style: TextStyle(color: Colors.yellow),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
