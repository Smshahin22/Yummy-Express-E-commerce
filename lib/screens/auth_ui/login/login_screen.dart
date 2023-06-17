import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yummy_express/constants/constants.dart';
import 'package:yummy_express/constants/routes.dart';
import 'package:yummy_express/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:yummy_express/screens/auth_ui/sign_up/sign_up.dart';
import 'package:yummy_express/screens/custom_bottom_bar/custom_bar_screen.dart';
import 'package:yummy_express/widgets/primary_button/primary_button.dart';
import 'package:yummy_express/widgets/top_titles/top_titles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const TopTitles(
                title: "Login", subtitle: "Welcome Back To Yummy Express App"),
            const SizedBox(height: 46),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                  hintText: "E-mail",
                  prefixIcon: Icon(
                      Icons.email_outlined)),
            ),
            const SizedBox(height: 12),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: password,
              obscureText: isShowPassword,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: const Icon(Icons.password_outlined),
                suffixIcon: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: Icon(
                    isShowPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            PrimaryButton(
              title: "Login",
              onPressed: () async {
                bool isVailidate = loginValidition(email.text, password.text);
                if (isVailidate) {
                  bool isLogined = await FirebaseAuthHelper.instance
                      .login(email.text, password.text, context);
                  if (isLogined) {
                    Routes.instance.pushAndRemoveUntil(
                        widget: const CustomBottomBarScreen(), context: context);
                  }
                }
              },
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                CupertinoButton(
                    onPressed: () {
                      Routes.instance
                          .push(widget: const SignUpScreen(), context: context);
                    },
                    child: const Text(
                      "SingUp",
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
