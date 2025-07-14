import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/widgets/AppButton.dart';
import 'package:gan/widgets/LabeledInputBox.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> sendPasswordResetEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      Fluttertoast.showToast(msg: 'Password reset email sent!');
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message ?? 'Error occurred.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            height: 500,
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              runAlignment: WrapAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsetsGeometry.directional(top: 50),
                  width: MediaQuery.sizeOf(context).width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        child: Text(
                          'FORGOT PASSWORD',
                          style: GoogleFonts.ibmPlexSans(
                            decoration: TextDecoration.none,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 7,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 4
                              ..color = const Color(0xC0305B7E),
                          ),
                        ),
                      ),
                      Align(
                        child: Text(
                          'FORGOT PASSWORD',
                          style: GoogleFonts.ibmPlexSans(
                            letterSpacing: 7,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            fontSize: 30,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 8),
                                blurRadius: 16,
                                color: Colors.black.withAlpha(64),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                LabeledInputBox(
                  isInputLocation: false,
                  label: 'Username or Email',
                  placeholder: 'email@domain.com',
                  textController: _emailController,
                  width: 320,
                ),
                AppButton(
                  text: "Request Reset Link",
                  width: 180,
                  onPressed: () async {
                    await sendPasswordResetEmail(); // 假设这是一个 Future 函数
                    // 成功后跳转回登录页
                    Navigator.of(
                      context,
                    ).pop(); // 如果是从 login page push 来的，pop 会回到 login
                    // 或者使用：
                    // Navigator.of(context).pushReplacementNamed('/login');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
