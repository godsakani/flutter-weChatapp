import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:wechat/Screens/chat_screen.dart';
import 'package:wechat/Screens/reg_screen.dart';
import 'package:wechat/utils/constant.dart';
import '../widgets/button_widget.dart';
import '../widgets/footer_widget.dart';
import '../widgets/textform_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String id = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  late bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: isLoading,
      blurEffectIntensity: 4,
      progressIndicator: SpinKitWave(
        color: primaryColor,
        size: 45.0,
      ),
      dismissible: false,
      opacity: 0.1,
      color: Color(0xFF121212),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Hero(
                  tag: 'icon',
                  child: Icon(
                    Icons.chat_rounded,
                    size: 50,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                //Welcome Text
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      "Welcome Back!",
                      textStyle: headingStyle1,
                      speed: Duration(milliseconds: 100),
                      curve: Curves.decelerate,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Connect With Friends!",
                  style: headingStyle2,
                ),
                const SizedBox(
                  height: 20,
                ),
                //Email
                Textform(
                  controller: emailController,
                  text: "Email",
                  textInputType: TextInputType.emailAddress,
                  obscure: false,
                  onchange: (value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                //password
                Textform(
                  controller: passwordController,
                  textInputType: TextInputType.visiblePassword,
                  obscure: true,
                  text: "Password",
                  onchange: (value) {
                    password = value;
                  },
                ),
                //Sign in button
                const SizedBox(
                  height: 15,
                ),
                ButtonField(
                  text: "LogIn",
                  ontap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      final currentUser =
                          await _auth.signInWithEmailAndPassword(
                              email: email.toString(),
                              password: password.toString());
                      if (currentUser != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        isLoading = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                //Creating account
                footerField(
                  text1: 'Do not have an account?',
                  ontap: () {
                    // Get.to(() => const RegistrationScreen());
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  text2: "SignUp",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
