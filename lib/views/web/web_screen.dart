import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paysliptask/utils/colors.dart';
import 'package:paysliptask/views/widgets/custom_textfield.dart';
import 'package:pdf/pdf.dart';
import 'package:toast/toast.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

class WebScreen extends StatefulWidget {
  @override
  _WebScreenState createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController daysWorkedController = TextEditingController();
  TextEditingController daysSickController = TextEditingController();
  TextEditingController daysOnleaveController = TextEditingController();

  int perHourRate = 20;
  double totalAmount;
  double totalCoid;
  double totalUif;
  double totalTax;
  int totalIncome;
  final pdf = pw.Document();


  @override
  Widget build(BuildContext context) {


    myGetBlobPdfContent();

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
                width: Size(MediaQuery.of(context).size.width * 0.5, 0),
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
                width: Size(MediaQuery.of(context).size.width * 0.5, 0),
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
                width: Size(MediaQuery.of(context).size.width * 0.5, 0),
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
                width: Size(MediaQuery.of(context).size.width * 0.5, 0),
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
                width: Size(MediaQuery.of(context).size.width * 0.5, 0),
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
                width: Size(MediaQuery.of(context).size.width * 0.5, 0),
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
                width: Size(MediaQuery.of(context).size.width * 0.5, 0),
              ),

              SizedBox(
                height: 20,
              ),

              Center(child: Text("Per hour rate is ${perHourRate}\$", style: TextStyle(fontSize: 20, color: AppColors.blueColor, fontWeight: FontWeight.w200),)),
              SizedBox(
                height: 20,
              ),


              Center(
                child: InkWell(
                  onTap: () async{
                    if(_formKey.currentState.validate()){
                      final url = html.Url.createObjectUrlFromBlob(await myGetBlobPdfContent());
                      html.window.open(url, "_blank");
                      html.Url.revokeObjectUrl(url);

                    }else{
                      Toast.show("Ivalid Form data", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    }
                  },
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


  Future<html.Blob> myGetBlobPdfContent() async {
    var data = await rootBundle.load("assets/ArialCE.ttf");
    var myFont = pw.Font.ttf(data);
    var myStyle = pw.TextStyle(font: myFont, fontSize: 24.0, color: PdfColors.blueAccent,);
    var mySty = pw.TextStyle(font: myFont, fontSize: 18.0);

    // we will assume that a person worked 8 hours in a day
    int totalHours = int.parse(daysWorkedController.text) * 8;
    totalIncome = perHourRate * totalHours ;
    totalCoid = totalIncome * (1/100);
    totalUif = totalIncome * (1/100);
    totalTax = totalIncome * (3.5/100);
    var total = totalCoid + totalUif + totalTax;
    totalAmount = totalIncome - total;

    final pdf = pw.Document();
    pdf.addPage(
        pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return <pw.Widget>  [

            pw.Header(
                level: 0,
                child: pw.Center(child: pw.Text("Employee Payment Slip", style: myStyle,),),
            ),

            pw.SizedBox(height: 10),


            pw.Text("Personal Info", style: mySty,),
            pw.SizedBox(height: 10),

            pw.Container(
              height: 2.0,
              color: PdfColors.black,
            ),

            pw.SizedBox(height: 20),

            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children:[

                pw.Row(
                  children: [
                    pw.Text("Employee Id:"),
                    pw.SizedBox(width: 10),
                    pw.Text(idNumberController.text),
                  ],
                ),

                pw.SizedBox(height: 5),

                pw.Row(
                  children: [
                    pw.Text("Name:"),
                    pw.SizedBox(width: 10),
                    pw.Text(nameController.text),
                  ],
                ),

                pw.SizedBox(height: 5),

                pw.Row(
                  children: [
                    pw.Text("SurName:"),
                    pw.SizedBox(width: 10),
                    pw.Text(surNameController.text),
                  ],
                ),

                pw.SizedBox(height: 5),
                pw.Row(
                  children: [
                    pw.Text("PhoneNo:"),
                    pw.SizedBox(width: 10),
                    pw.Text(phoneNumberController.text),
                  ],
                ),
              ],
            ),

            // work Info

            pw.SizedBox(height: 10),
            pw.Container(
              height: 2.0,
              color: PdfColors.black,
            ),

            pw.SizedBox(height: 10),
            pw.Text("Worked Info", style: mySty,),
            pw.SizedBox(height: 10),

            pw.Container(
              height: 2.0,
              color: PdfColors.black,
            ),

            pw.SizedBox(height: 10),

            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children:[

                pw.Row(
                  children: [
                    pw.Text("Total Worked days:"),
                    pw.SizedBox(width: 10),
                    pw.Text(daysWorkedController.text),
                  ],
                ),

                pw.SizedBox(height: 5),

                pw.Row(
                  children: [
                    pw.Text("Sick Days:"),
                    pw.SizedBox(width: 10),
                    pw.Text(daysSickController.text),
                  ],
                ),

                pw.SizedBox(height: 5),

                pw.Row(
                  children: [
                    pw.Text("Leave Days:"),
                    pw.SizedBox(width: 10),
                    pw.Text(daysOnleaveController.text),
                  ],
                ),

                pw.SizedBox(height: 5),
              ],
            ),


            // payment info


            pw.SizedBox(height: 10),
            pw.Container(
              height: 2.0,
              color: PdfColors.black,
            ),

            pw.SizedBox(height: 10),
            pw.Text("Payment Info", style: mySty,),
            pw.SizedBox(height: 10),

            pw.Container(
              height: 2.0,
              color: PdfColors.black,
            ),

            pw.SizedBox(height: 10),

            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children:[

                pw.Row(
                  children: [
                    pw.Text("Rate Per Hour:"),
                    pw.SizedBox(width: 10),
                    pw.Text("\$"+perHourRate.toString() ),
                  ],
                ),

                pw.SizedBox(height: 5),

                pw.Row(
                  children: [
                    pw.Text("Total Income:"),
                    pw.SizedBox(width: 10),
                    pw.Text("\$"+totalIncome.toString()),
                  ],
                ),

                pw.SizedBox(height: 5),

                pw.Row(
                  children: [
                    pw.Text("Coid(1% of total income):"),
                    pw.SizedBox(width: 10),
                    pw.Text("\$"+totalCoid.toString()),
                  ],
                ),

                pw.SizedBox(height: 5),

                pw.Row(
                  children: [
                    pw.Text("UIF(1% of total income):"),
                    pw.SizedBox(width: 10),
                    pw.Text("\$"+totalUif.toString()),
                  ],
                ),

                pw.SizedBox(height: 5),

                pw.Row(
                  children: [
                    pw.Text("Tax(3.5% of total income):"),
                    pw.SizedBox(width: 10),
                    pw.Text("\$"+totalTax.toString()),
                  ],
                ),

                pw.SizedBox(height: 5),

                pw.Row(
                  children: [
                    pw.Text("Total amount to pay:"),
                    pw.SizedBox(width: 10),
                    pw.Text("\$"+totalAmount.toString()),
                  ],
                ),

                pw.SizedBox(height: 5),
              ],
            ),

          ];
        }));


    final bytes = await pdf.save();
    html.Blob blob = html.Blob([bytes], 'application/pdf');
    return blob;
  }
}
