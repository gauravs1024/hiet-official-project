import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiet_official_project/Utils/AppColors.dart';
import 'package:hiet_official_project/Utils/CustomWidgets.dart';

import '../API/Api.dart';
import 'LoginPage.dart';
import 'package:http/http.dart' as http;
class AdmissionQueryPage extends StatefulWidget {
  const AdmissionQueryPage({super.key});
  @override
  State<AdmissionQueryPage> createState() => _AdmissionQueryPageState();
}

class _AdmissionQueryPageState extends State<AdmissionQueryPage> {
  String? _selectedPurpose;
  String? _selectedCourse;
  bool  _isLoading = false;
  late String id;
  final TextEditingController nameController=TextEditingController();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController phoneController=TextEditingController();
  final TextEditingController altPhoneController=TextEditingController();
  final TextEditingController contactPersonController=TextEditingController();
  final TextEditingController addressController=TextEditingController();




 void clearTextField(){
   nameController.clear();
   emailController.clear();
   phoneController.clear();
   altPhoneController.clear();
   contactPersonController.clear();
   addressController.clear();
   _selectedPurpose=null;


 }

 void inputTextValidation(){
    if(nameController.text==''||phoneController.text==''||
    contactPersonController.text==''||_selectedPurpose==null){
      CustomWidgets.showQuickAlert('Fill All the Necessary Fields (*)', 'error', context);
    }
    else{
      addVisitor();
    }
 }

  Future<void>addVisitor() async{
    setState(() {
      _isLoading = true;
    });
    const  timeoutDuration= Duration(seconds: 5);
    try{
      String uri = Api.addVisitor;

      final  loginRequest =http.post(
        Uri.parse(uri), body:{
        'email': emailController.text,
        'phone': phoneController.text,
        'name':nameController.text,
        'alternate_phone':altPhoneController.text,
        'contact_person':contactPersonController.text,
        'purpose':_selectedPurpose,
        'address':addressController.text,

      },
      );
      final response= await Future.any([loginRequest,Future.delayed(timeoutDuration)]);

      if (response.statusCode == 200) {
        var responseMsg = json.decode(response.body);
        print(responseMsg);
        if(responseMsg['status']==true){
          print(responseMsg['message']);
          CustomWidgets.showQuickAlert(responseMsg['message'], 'success', context);
          clearTextField();
        }
        else{
          _isLoading=false;
          CustomWidgets.showQuickAlert(responseMsg['message'],'error' , context);
        }
      }

    }
    catch(e){
      print('Exception thrown    $e');
      CustomWidgets.showQuickAlert('Exception','error' , context);
      _isLoading=false;
    }
    finally{
      _isLoading=false;
      setState(() {

      });
    }
  }

 

  @override
  void initState() {
    super.initState();
  }

  void dispose(){
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(21, 90, 105, 1),
        title: Text(
          'Admission Query Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 150,
              height: 150,
              child: Opacity(
                opacity: 0.2,
                child: Image.asset('assets/images/hiet-logo-clear-background.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                CustomWidgets.buildTextFormField('Visitor\'s name  *',nameController),
                 CustomWidgets.buildTextFormField('Email',emailController),


                Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      controller: phoneController,
                      style:  TextStyle(color: AppColors.primaryTextColor,fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF5E757C), width: 2.0),
                        ),
                        labelText:'+91-Phone Number  *' ,
                        labelStyle: TextStyle(color: AppColors.primaryTextColor,fontWeight: FontWeight.bold),
                      ),
                    )),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      controller: altPhoneController,
                      style:  TextStyle(color: AppColors.primaryTextColor,fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF5E757C), width: 2.0),
                        ),
                        labelText: '+91-Alternate Phone Number',
                        labelStyle: TextStyle(color: AppColors.primaryTextColor,fontWeight: FontWeight.bold),
                      ),
                    )),



                 CustomWidgets.buildTextFormField('Contact Person   *',contactPersonController),
                 CustomWidgets.buildTextFormField('Visitor Address',addressController),
                Text(
                  'Purpose  *',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: AppColors.primaryColor),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(border:Border.all(color: AppColors.borderColor),borderRadius:BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        ListTile(
                          title: CustomWidgets.buildSimpleText('Admission'),
                          leading: Radio<String>(
                            activeColor: AppColors.primaryColor,
                            value: 'Admission',
                            groupValue: _selectedPurpose,
                            onChanged: (value) {
                              setState(() {
                                _selectedPurpose = value;
                                print(_selectedPurpose);
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: CustomWidgets.buildSimpleText('Other'),
                          leading: Radio<String>(
                            activeColor: AppColors.primaryColor,
                            value: 'Other',
                            groupValue: _selectedPurpose,
                            onChanged: (value) {
                              setState(() {
                                _selectedPurpose = value;
                                print(_selectedPurpose);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),

                SizedBox(height: 10,),
                Divider(
                  height: 1,
                ),
                SizedBox(height: 10,),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(21, 90, 105, 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: (
                          ) {
                      inputTextValidation();
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: const Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
