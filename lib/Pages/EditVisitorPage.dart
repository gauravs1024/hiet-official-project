import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiet_official_project/Pages/ViewQueryFormPage.dart';
import 'package:http/http.dart' as http;
import '../API/Api.dart';
import '../Utils/AppColors.dart';
import '../Utils/CustomWidgets.dart';

class EditVisitorPage extends StatefulWidget{
 final String visitorName;
 final String email;
 final String phone;
 final String altPhone;
 final String contactPerson;
 final String address;
 final String id;
 final String purpose;




   const EditVisitorPage({super.key,
     required this.visitorName,
     required this.email,
     required this.phone,
     required this.altPhone,
     required this.contactPerson,
     required this.address,
     required this.id,
     required this.purpose
  });

  @override
  State<EditVisitorPage> createState() => _EditVisitorPageState();
}

class _EditVisitorPageState extends State<EditVisitorPage> {

  String? _selectedPurpose;
  String? _selectedCourse;
  bool  _isLoading = false;
  bool _isDispose=false;
  late String id;
  final TextEditingController nameController=TextEditingController();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController phoneController=TextEditingController();
  final TextEditingController altPhoneController=TextEditingController();
  final TextEditingController contactPersonController=TextEditingController();
  final TextEditingController addressController=TextEditingController();
  final TextEditingController purposeController=TextEditingController();
  void clearTextField(){
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    altPhoneController.clear();
    contactPersonController.clear();
    addressController.clear();
    purposeController.clear();


  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    altPhoneController.dispose();
    contactPersonController.dispose();
    addressController.dispose();
    purposeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController.text=widget.visitorName;
    emailController.text=widget.email;
    phoneController.text=widget.phone;
    altPhoneController.text=widget.altPhone;
    contactPersonController.text=widget.contactPerson;
    addressController.text=widget.address;
    purposeController.text=widget.purpose;
    id=widget.id;
  }

  Future<void>editVisitor() async{
    setState(() {
      _isLoading = true;
    });
    const  timeoutDuration= Duration(seconds: 5);
    try{
      String uri = Api.editVisitor;

      final  loginRequest =http.post(
        Uri.parse(uri), body:{
        'email': emailController.text,
        'phone': phoneController.text,
        'name':nameController.text,
        'alternate_phone':altPhoneController.text,
        'contact_person':contactPersonController.text,
        'purpose':purposeController.text,
        'address':addressController.text,
        'id':id

      },
      );
      final response= await Future.any([loginRequest,Future.delayed(timeoutDuration)]);

      if (response.statusCode == 200) {
        var responseMsg = json.decode(response.body);
        print(responseMsg);
        if(responseMsg['status']==true){
          clearTextField();
          CustomWidgets.showQuickAlert(responseMsg['message'],'success',context);
           // await Future.delayed(const Duration(seconds: 2));
           _isDispose=true;
          handleEditFunction();
          // Navigator.push(context, MaterialPageRoute(builder: (_)=>const ViewQueryFormPage()));
        }
        else{
          _isLoading=false;
        }
      }

    }
    catch(e){
      print('Exception thrown    $e');
      _isLoading=false;
    }
    finally{
      _isLoading=false;
      if(!_isDispose)
      setState(() {

      });
    }
  }

  void handleEditFunction()async{
    await Future.delayed(Duration(seconds: 3));
    if(context.mounted)
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>ViewQueryFormPage()));
  }


  void textValidation(){
    if(nameController.text==''||phoneController.text==''||
    contactPersonController.text==''||purposeController.text==''){
      CustomWidgets.showQuickAlert('Please Fill All The Fields', 'error', context);
    }
    else if(phoneController.text.length<10||altPhoneController.text.length<10){
      CustomWidgets.showQuickAlert('Phone Number must be 10 digits', 'error', context);
    }
    else{
      editVisitor();
    }
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 90, 105, 1),
        title: const Text(
          'Edit Query Page',
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
                const SizedBox(height: 10,),
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
                      labelText: 'Phone Number  *',
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
                        labelText: 'Alternate Phone Number',
                        labelStyle: TextStyle(color: AppColors.primaryTextColor,fontWeight: FontWeight.bold),
                      ),
                    )),
                CustomWidgets.buildTextFormField('Contact Person  *',contactPersonController),
                CustomWidgets.buildTextFormField('Purpose  *',purposeController),
                CustomWidgets.buildTextFormField('Visitor Address',addressController),


                const Divider(
                  height: 1,
                ),
                // Text("Program",
                //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                // Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(),
                //     borderRadius: BorderRadius.circular(10)
                //   ),
                //   width: 300,
                //   child: SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: DropdownButton<String>(
                //       value: _selectedCourse,
                //       hint: Text("Select a course"),
                //       onChanged: (String? newValue) {
                //         setState(() {
                //           _selectedCourse = newValue;
                //         });
                //       },
                //       items: courses.map<DropdownMenuItem<String>>((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Text(
                //             value,
                //             overflow: TextOverflow.ellipsis,
                //           ),
                //         );
                //       }).toList(),
                //     ),
                //   ),
                // ),

                const SizedBox(height: 10,),
                const Divider(
                  height: 1,
                ),
                const SizedBox(height: 10,),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(21, 90, 105, 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: (
                          ) {
                        textValidation();
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: const Center(
                        child: Text(
                          'Update',
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