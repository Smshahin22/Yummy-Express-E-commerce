import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yummy_express/constants/constants.dart';
import 'package:yummy_express/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:yummy_express/models/user_model/user_model.dart';
import 'package:yummy_express/provider/app_provider.dart';
import 'package:yummy_express/widgets/primary_button/primary_button.dart';



class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  File? image;

  void takePicture() async {
    XFile? value = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          image == null
         ? CupertinoButton(
            onPressed: () {
              takePicture();
            },
            child:  CircleAvatar(
              radius: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Photo"),
                  Icon(Icons.camera_alt),
                ],
              )),
          )
          : CupertinoButton(
              onPressed: () {
                takePicture();
              },
            child: CircleAvatar(
              backgroundImage: FileImage(image!),
              radius: 70,
            ),
          ),

          const SizedBox(height: 12),

          TextFormField(
            controller: textEditingController,
            decoration:
                InputDecoration(
                    hintText: appProvider.getUserInformation.name
                ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 250,
            child: PrimaryButton(
              title: "Update",
              onPressed: () async{
                UserModel userModel = appProvider.getUserInformation.copyWith(name: textEditingController.text);
                appProvider.updateUserInfoFirebase(context, userModel, image);
              },
            ),
          )
        ],
      ),
    );
  }
}
