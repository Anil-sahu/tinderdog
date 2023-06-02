import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
 bool? isObs=false;

   CustomTextField({
    Key? key,
    this.hintText,
    this.controller,
     this.isObs
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        obscureText:isObs??false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 14, right: 14),
          hintText: hintText,
          hintStyle: const TextStyle(letterSpacing: 0.6,
                fontSize: 14,),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          
        ),
        
      ),
    );
  }
}
