import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yummy_express/constants/routes.dart';
import 'package:yummy_express/screens/auth_ui/login/login_screen.dart';
import 'package:yummy_express/screens/custom_bottom_bar/custom_bar_screen.dart';
import 'package:yummy_express/screens/home/home_screen.dart';
import 'package:yummy_express/widgets/primary_button/primary_button.dart';
import 'package:yummy_express/widgets/top_titles/top_titles.dart';

import '../../../constants/constants.dart';
import '../../../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitles(
                  title: "Create Account", subtitle: "Welcome Back To Yummy Express App"),
              const SizedBox(height: 46),

              TextFormField(
                controller: name,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    hintText: "Name",
                    prefixIcon: Icon(
                        Icons.person_outline
                    )),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: "E-mail",
                    prefixIcon: Icon(
                        Icons.email_outlined
                    )),
              ),


              const SizedBox(height: 12),

              TextFormField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    hintText: "Phone",
                    prefixIcon: Icon(
                        Icons.phone
                    )),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: password,
                keyboardType: TextInputType.number,
                obscureText: isShowPassword,
                decoration:  InputDecoration(
                  hintText: "Password",
                  prefixIcon: const Icon(
                      Icons.password_outlined
                  ),
                  suffixIcon: CupertinoButton(
                    onPressed: (){
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



              const SizedBox(height: 16),

              PrimaryButton(
                title: "Create an Account",
                onPressed: () async{
                  bool isVailidate = signUpVaildation(email.text, password.text, name.text, phone.text);
                  if (isVailidate) {
                    bool isLogined = await FirebaseAuthHelper.instance
                        .signUp(name.text, email.text, password.text, context);
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
                  const Text("I have already an account?"),
                  CupertinoButton(
                      onPressed: (){
                        Routes.instance
                            .push(widget: const LoginScreen(), context: context);

                      },
                      child: const Text("Login", ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
