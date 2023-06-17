import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yummy_express/constants/constants.dart';
import 'package:yummy_express/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';

import '../../widgets/primary_button/primary_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

bool  isShowPassword = true;
TextEditingController newPassword = TextEditingController();
TextEditingController confrimPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Change Password",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 100),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: newPassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: "New Password",
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

          const SizedBox(height: 12),

          TextFormField(
            keyboardType: TextInputType.number,
            controller: confrimPassword,
            obscureText: isShowPassword,
            decoration: const InputDecoration(
              hintText: "Confrim Password",
              prefixIcon: Icon(Icons.password_outlined),
              // suffixIcon: CupertinoButton(
              //   onPressed: () {
              //     setState(() {
              //       isShowPassword = !isShowPassword;
              //     });
              //   },
              //   padding: EdgeInsets.zero,
              //   child: Icon(
              //     isShowPassword
              //         ? Icons.visibility_outlined
              //         : Icons.visibility_off_outlined,
              //     color: Colors.grey,
              //   ),
              // ),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: 250,
            child: PrimaryButton(
              title: "Update",
              onPressed: () async{

                if(newPassword.text.isEmpty) {
                  showMessage("New Password is empty");
                }else if (confrimPassword.text.isEmpty) {
                  showMessage("Confrim password is empty");
                }else if (confrimPassword.text == newPassword.text) {
                  FirebaseAuthHelper.instance.changePassword(newPassword.text, context);
                } else {
                  showMessage("Confrim password is not match");
                }


                  },
            ),
          )
        ],
      ),
    );
  }
}
