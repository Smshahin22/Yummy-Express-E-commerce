import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yummy_express/constants/asset_images.dart';
import 'package:yummy_express/constants/routes.dart';
import 'package:yummy_express/screens/auth_ui/login/login_screen.dart';
import 'package:yummy_express/screens/auth_ui/sign_up/sign_up.dart';
import 'package:yummy_express/widgets/primary_button/primary_button.dart';
import 'package:yummy_express/widgets/top_titles/top_titles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///
            const TopTitles(title: "Yummy Express App",
                subtitle: "Buy any item from using app"),
            Center(
              child: Image.asset(AssetsImages.instance.welcomeImage),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    Icons.facebook,
                    size: 35,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                CupertinoButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  child:
                      Image.asset(AssetsImages.instance.googleLogo, scale: 28),
                ),
              ],
            ),
            const SizedBox(height: 15),

            SizedBox(
              width: 300,
              child: PrimaryButton(
                  onPressed: () {
                    Routes.instance.push(widget: const LoginScreen(),context: context);
                  },
                  title: "Log-in"),
            ),

            const SizedBox(height: 10),
            PrimaryButton(
                onPressed: () {
                  Routes.instance.push(widget: SignUpScreen(), context: context);
                },
                title: "Sign-Up"),
          ],
        ),
      ),
    );
  }
}
