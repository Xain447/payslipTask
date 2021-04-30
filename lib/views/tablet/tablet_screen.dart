import 'package:flutter/material.dart';
import 'package:paysliptask/utils/colors.dart';
import 'package:paysliptask/views/widgets/custom_textfield.dart';

class TabletScreen extends StatefulWidget {
  @override
  _TabletScreenState createState() => _TabletScreenState();
}

class _TabletScreenState extends State<TabletScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController daysWorkedController = TextEditingController();
  TextEditingController daysSickController = TextEditingController();
  TextEditingController daysOnleaveController = TextEditingController();

  int perHourRate = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 50,),
              Center(child: Text("Payslip Genrator", style: TextStyle(fontSize: 30, color: AppColors.blueColor, fontWeight: FontWeight.w800),)),
              SizedBox(height: 50,),


              // employee id

              CustomTextField(
                controller: idNumberController,
                hintText: "Employee ID Number",
                inputType: TextInputType.number,
                icon: Icons.title,
                width: Size(MediaQuery.of(context).size.width * 0.4, 0),
              ),
              SizedBox(
                height: 10,
              ),

              // employee name

              CustomTextField(
                controller: nameController,
                hintText: "Employee Name",
                inputType: TextInputType.text,
                icon: Icons.person,
                width: Size(MediaQuery.of(context).size.width * 0.4, 0),
              ),
              SizedBox(
                height: 10,
              ),


              // employee surname

              CustomTextField(
                controller: surNameController,
                hintText: "Employee SurName",
                inputType: TextInputType.text,
                icon: Icons.person,
                width: Size(MediaQuery.of(context).size.width * 0.4, 0),
              ),
              SizedBox(
                height: 10,
              ),


              // employee phone number

              CustomTextField(
                controller: phoneNumberController,
                hintText: "Employee Phone Number",
                inputType: TextInputType.phone,
                icon: Icons.call,
                width: Size(MediaQuery.of(context).size.width * 0.4, 0),
              ),
              SizedBox(
                height: 10,
              ),

              // employee days worked

              CustomTextField(
                controller: daysWorkedController,
                hintText: "Employee days worked",
                inputType: TextInputType.text,
                icon: Icons.work,
                width: Size(MediaQuery.of(context).size.width * 0.4, 0),
              ),
              SizedBox(
                height: 10,
              ),


              // employee days sick

              CustomTextField(
                controller: daysSickController,
                hintText: "Employee days sick",
                inputType: TextInputType.text,
                icon: Icons.work,
                width: Size(MediaQuery.of(context).size.width * 0.4, 0),
              ),
              SizedBox(
                height: 10,
              ),


              // employee days onleave

              CustomTextField(
                controller: daysOnleaveController,
                hintText: "Employee days onLeave",
                inputType: TextInputType.text,
                icon: Icons.work,
                width: Size(MediaQuery.of(context).size.width * 0.4, 0),
              ),

              SizedBox(
                height: 20,
              ),

              Center(child: Text("Per hour rate is ${perHourRate}\$", style: TextStyle(fontSize: 20, color: AppColors.blueColor, fontWeight: FontWeight.w200),)),
              SizedBox(
                height: 20,
              ),


              Center(
                child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(child: Text("Generate Report", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),))
                ),
              ),

              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
