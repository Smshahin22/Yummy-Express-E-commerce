import 'package:flutter/material.dart';

class TopTitles extends StatelessWidget {
 final String title;
 final String subtitle;
  const TopTitles({Key? key, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: SizedBox(
            // height: kToolbarHeight + 12,
            height: 12,

          ),
        ),
        if (title == "Login" || title == "Create Account")
          GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
            child: const Icon(Icons.arrow_back_ios),
          ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(
              fontSize: 18,
            fontWeight: FontWeight.w400
          ),
        ),
      ],
    );
  }
}
