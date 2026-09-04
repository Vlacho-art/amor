import 'package:flutter/material.dart';
import 'components/descrit.dart';
import 'components/home.dart';
import 'components/shopping.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const Scaffold(body: LoginScreen()),
        '/home': (_) => const Home(),
        '/shopping': (_) => const ShoppingCartScreen(),
        '/detail': (_) => const Descrit(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bool _obscurePassword = true;

  static const Color kPink = Color(0xFFE0245E);
  static const Color kDarkText = Color(0xFF1A1A2E);
  static const Color kGreyText = Color(0xFF8E8E93);
  static const Color kFieldBg = Color(0xFFF5F5F7);
  static const Color kLogoBg = Color(0xFF0E1F1C);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 60),
            _buildLogo(),
            const SizedBox(height: 24),
            const Text(
              'Welcome Back',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: kDarkText,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Sign in to your private account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: kGreyText,
              ),
            ),
            const SizedBox(height: 40),
            _buildLabel('EMAIL ADDRESS'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _emailController,
              hintText: 'name@example.com',
              obscureText: false,
            ),
            const SizedBox(height: 24),
            _buildLabel('PASSWORD'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _passwordController,
              hintText: '••••••••',
              obscureText: _obscurePassword,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/home'),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 15,
                    color: kGreyText,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSignInButton(),
            const SizedBox(height: 28),
            _buildSignUpRow(),
            const SizedBox(height: 32),
            _buildFooter(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Container(
        width: 96,
        height: 96,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFF3F3F5),
        ),
        child: Center(
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: kLogoBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'A',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4FD1C5),
                        ),
                      ),
                      TextSpan(
                        text: 'P',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE0B24F),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'natural',
                  style: TextStyle(
                    fontSize: 6,
                    color: Colors.white70,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: kGreyText,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: kFieldBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(fontSize: 16, color: kDarkText),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFFB4B4BA)),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(
              builder: (_) => const Home(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPink,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: kPink.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Sign In',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(fontSize: 15, color: kGreyText),
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'Create one',
            style: TextStyle(
              fontSize: 15,
              color: kPink,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return const Text(
      'DISCRETE BILLING & SECURE CONNECTION\nGUARANTEED',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 11,
        color: Color(0xFFC7C7CC),
        letterSpacing: 0.3,
        height: 1.5,
      ),
    );
  }
}