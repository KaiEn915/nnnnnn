
import 'package:flutter/material.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/widgets/AppButton.dart';
import 'package:gan/widgets/LabeledInputBox.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 700,
                      child: Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        runAlignment: WrapAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsetsGeometry.directional(top: 50),
                            width: MediaQuery.sizeOf(context).width,
                            child: Stack(
                              children: [
                                Align(
                                  child: Text(
                                    'SIGN UP',
                                    style: GoogleFonts.ibmPlexSans(
                                      decoration: TextDecoration.none,
                                      fontSize: 60,
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
                                    'SIGN UP',
                                    style: GoogleFonts.ibmPlexSans(
                                      letterSpacing: 7,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                      fontSize: 60,
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
                                // Fill
                              ],
                            ),
                          ),
                          LabeledInputBox(
                            isInputLocation: false,
                            label: 'Username or Email',
                            placeholder: 'email@domain.com',
                            width: 320,
                            textController: emailController,
                          ),
                          LabeledInputBox(
                            isInputLocation: false,
                            label: 'Password',
                            placeholder: '*******',
                            width: 320,
                            isObscure: true,
                            textController: passwordController,
                          ),
                          LabeledInputBox(
                            isInputLocation: false,
                            label: 'Confirm Password',
                            placeholder: '*******',
                            width: 320,
                            isObscure: true,
                            textController: confirmPasswordController,
                          ),
                          AppButton(
                            text: "Sign Up",
                            width: 140,
                            onPressed: () {
                              AuthService.createAccountWithEmailAndPassword(
                                emailController.text,
                                passwordController.text,
                                confirmPasswordController.text,
                              );
                            },
                          ),
                          Row(
                            spacing: 8,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE6E6E6),
                                  ),
                                ),
                              ),
                              Text(
                                'or',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF828282),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE6E6E6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 320,
                            height: 40,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFEEEEEE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 77.50,
                                  top: 10,
                                  child: GestureDetector(
                                    onTap: ()=>{AuthService.loginOrSignUpWithGoogle()},
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      spacing: 8,
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(),
                                          child: Image.asset(
                                            "assets/images/googleLogo.png",
                                          ),
                                        ),
                                        Text(
                                          'Continue with Google',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 187,
                    top: 90,
                    child: Text(
                      '\n',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
