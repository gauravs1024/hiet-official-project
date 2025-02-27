import 'dart:convert';

import 'package:flutter/material.dart';

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



  final List<String> courses = [
    'B.Tech. (Computer Science Engineering)',
    'B.Tech. (CS - Artificial Intelligence & Machine Learning)',
    'B.Tech. (Information Technology)',
    'B.Tech. (Electronics & Communication Engineering)',
    'B.Tech. (Electrical Engineering',
    'B.Tech. (Mechanical Engineering)',
    'MCA',
    'MBA',
    'BCA',
    'BBA',
    'B.Ed.',
    'Diploma (Mechanical Engineering)',
    'Diploma (Electrical Engineering)',
    'Diploma (Civil Engineering)',
    'Diploma (Computer Science)',
    'Diploma (Fashion Design & Garment Technology)'
  ];
 void clearTextField(){
   nameController.clear();
   emailController.clear();
   phoneController.clear();
   altPhoneController.clear();
   contactPersonController.clear();
   addressController.clear();
   _selectedPurpose=null;


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
          clearTextField();
        }
        else{
          _isLoading=false;
          print(responseMsg['message']);
        }
      }

    }
    catch(e){
      print('Exception thrown    $e');
      _isLoading=false;
    }
    finally{
      _isLoading=false;
      setState(() {

      });
    }
  }

  Widget buildTextFormField(String label, TextEditingController controller) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: TextFormField(
          controller: controller,
          style: const TextStyle(color: Color(0xFF1A3037)),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF5E757C), width: 2.0),
            ),
            labelText: label,
            labelStyle: TextStyle(color: Color(0xFF4E4C39)),
          ),
        ));
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
                buildTextFormField('Visitor\'s name',nameController),
                buildTextFormField('Email',emailController),
                buildTextFormField('Phone Number',phoneController),
                buildTextFormField('Alternate Phone Number ',altPhoneController),
                buildTextFormField('Contact Person ',contactPersonController),
                buildTextFormField('Visitor Address',addressController),
                Text(
                  'Purpose',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  title: Text('Admission'),
                  leading: Radio<String>(
                    activeColor: Color.fromRGBO(21, 90, 105, 1),
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
                  title: Text('Other'),
                  leading: Radio<String>(
                    activeColor: Color.fromRGBO(21, 90, 105, 1),
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
                Divider(
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
                        addVisitor();
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
