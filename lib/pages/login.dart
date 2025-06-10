import 'package:flutter/material.dart';
import 'package:gan/widgets/AppButton.dart';
import 'package:gan/widgets/LabeledInputBox.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);

Future<void> _handleSignIn() async {
  try {
    await _googleSignIn.signIn();
  } catch (error) {
    print(error);
  }
}

Future<void> signInUsingEmail(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print('Login Successful: ${userCredential.user?.email}');
  } catch (e) {
    print('Error: $e');
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                Positioned(
                  top: 100,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 200,
                    child: Stack(
                      children: [
                        Align(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 60,
                              letterSpacing: 7,
                              fontFamily: 'Inter',
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = const Color(0xFF305B7E),
                            ),
                          ),
                        ),
                        Align(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              letterSpacing: 7,
                              decoration: TextDecoration.none,
                              fontSize: 60,
                              fontFamily: 'Inter',
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
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 100),
                    width: 400,
                    height: 500,
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      runAlignment: WrapAlignment.spaceBetween,
                      children: [
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
                            signInUsingEmail(
                              emailController.text,
                              passwordController.text,
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
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 8,
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Image.asset(
                                        "assets/images/cat.png",
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
