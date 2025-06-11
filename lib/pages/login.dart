import 'package:flutter/material.dart';
import 'package:gan/widgets/AppButton.dart';
import 'package:gan/widgets/LabeledInputBox.dart';
import 'package:gan/pages/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];
GoogleSignIn _googleSignIn = GoogleSignIn(scopes: scopes);

Future<void> SignInUsingGoogle() async {
  try {
    await _googleSignIn.signIn();

    print("Login success!");
  } catch (error) {
    print(error);
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> SignInUsingEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('Login Successful: ${userCredential.user?.email}');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
                                  'LOGIN',
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
                                  'LOGIN',
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
                          label: 'Username or Email',
                          placeholder: 'email@domain.com',
                          width: 320,
                          hasBackground: false,
                          controller: emailController,
                        ),
                        LabeledInputBox(
                          label: 'Password',
                          placeholder: '*******',
                          width: 320,
                          hasBackground: false,
                          controller: passwordController,
                        ),
                        AppButton(
                          text: "Login",
                          width: 320,
                          onPressed: () {
                            SignInUsingEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Home(),
                              ),
                            );
                          },
                        ),
                        AppButton(
                          text: "Forgot Password",
                          width: 140,
                          onPressed: () {},
                        ),
                        AppButton(
                          text: "Sign Up",
                          width: 140,
                          onPressed: () {},
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
                                  onTap: SignInUsingGoogle,
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
    );
  }
}
