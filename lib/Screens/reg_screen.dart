import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechat/Screens/chat_screen.dart';
import 'package:wechat/Screens/login_screen.dart';
import 'package:wechat/utils/constant.dart';
import 'package:wechat/widgets/button_widget.dart';
import 'package:wechat/widgets/footer_widget.dart';
import 'package:wechat/widgets/textform_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static const String id = "registration";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

final TextEditingController userNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String? username;
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
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),

                  ///Logo
                  const Hero(
                    tag: 'icon',
                    child: Icon(
                      Icons.chat,
                      size: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  ///Welcome Text
                  const Text(
                    "Hi There!",
                    style: headingStyle1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Connect and Share!",
                    style: headingStyle2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  ///UserName
                  Textform(
                    controller: userNameController,
                    text: "Username",
                    textInputType: TextInputType.name,
                    obscure: false,
                    onchange: (value) {
                      userNameController.text = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  ///email
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

                  ///password
                  Textform(
                    controller: passwordController,
                    text: "Password",
                    textInputType: TextInputType.visiblePassword,
                    obscure: true,
                    onchange: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  ///button
                  ButtonField(
                    text: "SignUp",
                    ontap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email.toString(),
                                password: password.toString());
                        if (newUser != null) {
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

                  ///footer
                  footerField(
                    text1: "Already have an account?",
                    text2: "LogIn!",
                    ontap: () {
                      // Get.to(() => const LoginScreen());
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
