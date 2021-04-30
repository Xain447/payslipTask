import 'package:flutter/material.dart';
import 'package:paysliptask/utils/colors.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;
  final IconData icon;
  final Size width;
  CustomTextField({@required this.controller, @required this.hintText, @required this.inputType, @required this.icon, @required this.width});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 60,
        width: width.width,
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter value';
            }
            return null;
          },
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.blueColor, width: 2.0),
              borderRadius: BorderRadius.circular(20.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.blueColor, width: 2.0),
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,

            prefixIcon: Icon(
              icon,
              color: AppColors.blueColor,
            ),
            errorStyle: TextStyle(color: Colors.red),
          ),

          keyboardType: inputType,

        ),
      ),
    );
  }
}