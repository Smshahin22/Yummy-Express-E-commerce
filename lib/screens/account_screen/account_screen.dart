import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yummy_express/constants/routes.dart';
import 'package:yummy_express/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:yummy_express/screens/change_password/change_password_screen.dart';
import 'package:yummy_express/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:yummy_express/widgets/primary_button/primary_button.dart';

import '../../provider/app_provider.dart';
import '../favourite_screen/favourite_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Account",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                appProvider.getUserInformation.image == null
                    ? const Icon(
                  Icons.person_outline,
                  size: 120,
                )
                    : CircleAvatar(
                  backgroundImage:
                  NetworkImage(appProvider.getUserInformation.image!),
                  radius: 60,
                ),
               const SizedBox(height: 8),
                Text(
                  appProvider.getUserInformation.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  appProvider.getUserInformation.email,
                ),
                // const SizedBox(
                //   height: 8.0,
                // ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 250,
                  child: PrimaryButton(
                    title: "Edit Profile",
                    onPressed: () {
                      Routes.instance
                          .push(widget: const EditProfileScreen(), context: context);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title: const Text("Your Order"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance.push(widget: FavouriteScreen(), context: context);
                  },
                  leading: const Icon(Icons.favorite_outline),
                  title: const Text("Favorite"),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.info_outline),
                  title: const Text("About us"),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.support_outlined),
                  title: const Text("Support"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance.push(widget: const ChangePasswordScreen(), context: context);
                  },
                  leading: const Icon(Icons.change_circle),
                  title: const Text("Change password"),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      FirebaseAuthHelper.instance.signOut();
                    });
                  },
                  leading: const Icon(Icons.exit_to_app_outlined),
                  title: const Text("Log out"),
                ),
                const SizedBox(height: 12),
                const Text("Version 1.0.0"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
