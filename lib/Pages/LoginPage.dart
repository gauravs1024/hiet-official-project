
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiet_official_project/API/Api.dart';
import 'package:hiet_official_project/Pages/HomePage.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import '../Utils/AppColors.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});
  @override
  State<LoginPage> createState()=>_LoginPageState();



}
class _LoginPageState extends State<LoginPage>{
  bool isLoginPage=true;
  bool _isObscured=true;
  bool _isLoading=false;

  final TextEditingController emailPhoneController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController nameController=TextEditingController();
  final TextEditingController confirmPasswordController=TextEditingController();
  void _togglePasswordVisibilty(){
    setState(() {
      _isObscured=!_isObscured;
    });
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading=false;
  }

  void dispose(){
    nameController.dispose();
    passwordController.dispose();
    emailPhoneController.dispose();
    confirmPasswordController.dispose();
    super.dispose();

  }

Future<void>userLogin() async{
  setState(() {
    _isLoading = true;
  });
  const  timeoutDuration= Duration(seconds: 5);
  try{
    String uri = Api.login;
    final  loginRequest =http.post(
      Uri.parse(uri), body:{
      'email': emailPhoneController.text,
      'password': passwordController.text
      },
    );
    final response= await Future.any([loginRequest,Future.delayed(timeoutDuration)]);

      if (response.statusCode == 200) {
        var responseMsg = json.decode(response.body);
        print(responseMsg);
        if(responseMsg['status']==true){
          print(responseMsg['message']);
          emailPhoneController.clear();
          passwordController.clear();
          Navigator.push(context,MaterialPageRoute(builder: (_)=>const HomePage()));
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


  Widget buildTextFormField(String label,TextEditingController controller){
   return Container(
        padding: const EdgeInsets.all(8.0),
    decoration: const BoxDecoration(
    border: Border(bottom: BorderSide(color: Colors.grey))
    ),
    child:TextFormField(
    controller: controller,
    style: const TextStyle(color:Color(0xFF1A3037)),
    decoration: InputDecoration(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.borderColor,width: 2.0),),
    labelText: label,
    labelStyle: TextStyle(color: AppColors.primaryTextColor),
    ),
    )
    );
  }

  Widget buildLoginCard(){
    return Card(
      elevation: 20,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children:<Widget> [
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                // border: Border.all(color: Colors.black,width: 2),
                image: DecorationImage(
                  image: AssetImage('assets/images/hiet-logo-clear-background.png'),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top:30),
              child:Center(
                child: Text("Login",
                  style: TextStyle(
                      color:AppColors.primaryTextColor,fontSize:20,fontWeight:FontWeight.bold
                  ),),
              ) ,
            ),


           buildTextFormField('Email or Phone number',emailPhoneController),


            Container(
              padding: const EdgeInsets.all(8.0),
              decoration:  BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.borderColor))
              ),
              child: TextFormField(
                controller: passwordController,
                  obscureText: _isObscured,
                  style:  TextStyle(color:AppColors.borderColor),
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.borderColor,width: 2.0),),
                      labelText: 'Password ',
                      labelStyle:  TextStyle(color: AppColors.primaryTextColor),
                      suffixIcon: IconButton( icon:
                      Icon(_isObscured ?Icons.visibility:Icons.visibility_off,),
                        onPressed: _togglePasswordVisibilty,
                      )
                  )
              ),
            ),

            const SizedBox(height: 10,),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 30.0,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    userLogin();
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
             Row(
               children: [
                 GestureDetector(
                   onTap: (){},
                   child: Text("Forgot Password?",
                       style: TextStyle(color:Color.fromRGBO(1, 10, 174, 1.0), fontWeight: FontWeight.bold)),
                 ),
                 TextButton(onPressed: (){
                   isLoginPage=false;
                   setState(() {

                   });
                 }, child: Text("Signup",
                     style: TextStyle(color: Color.fromRGBO(1, 10, 174, 1.0), fontWeight: FontWeight.bold))
                 )
               ],
             )
          ],
        ),
      ),
    );
  }

  Widget buildSignupCard(){
    return Card(
      elevation: 20,
      // margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children:<Widget> [

            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                // border: Border.all(color: Colors.black,width: 2),
                image: DecorationImage(
                  image: AssetImage('assets/images/hiet-logo-clear-background.png'),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top:10),
              child: Center(
                child: Text("SignUp",
                  style: TextStyle(
                      color: AppColors.primaryTextColor,fontSize:20,fontWeight:FontWeight.bold
                  ),),
              ) ,
            ),

          buildTextFormField('Name',nameController),
            buildTextFormField('Email or Phone number',emailPhoneController),


            Container(
              padding: const EdgeInsets.all(8.0),
              decoration:  BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.borderColor))
              ),
              child: TextFormField(
                  obscureText: _isObscured,
                  style:  TextStyle(color:AppColors.borderColor),
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.borderColor,width: 2.0),),
                      labelText: 'Password ',
                      labelStyle:  TextStyle(color: AppColors.primaryTextColor),
                      suffixIcon: IconButton( icon:
                      Icon(_isObscured ?Icons.visibility:Icons.visibility_off,),
                        onPressed: _togglePasswordVisibilty,
                      )
                  )
              ),
            ),

            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))
              ),
              child: TextFormField(
                controller: confirmPasswordController,
                  obscureText: _isObscured,
                  style:  TextStyle(color: AppColors.borderColor),
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.borderColor,width: 2.0),),
                      labelText: 'Confirm Password ',
                      labelStyle: TextStyle(color: AppColors.primaryTextColor),
                      suffixIcon: IconButton( icon:
                      Icon(_isObscured ?Icons.visibility:Icons.visibility_off,),
                        onPressed: _togglePasswordVisibilty,
                      )
                  )
              ),
            ),


            const SizedBox(height: 10,),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 30.0,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: const Center(
                    child: Text(
                      'Signup',
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
            TextButton(onPressed: (){
              isLoginPage=true;
              setState(() {

              });
            }, child: Text("Already Registered? Login",
                style: TextStyle(color: Color.fromRGBO(1, 10, 174, 1.0), fontWeight: FontWeight.bold))
            )
             ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
        // backgroundColor:,
        backgroundColor: Colors.white,
        body:Container(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset('assets/images/background.jpg',
                  fit: BoxFit.fill,
                ),
              ),

              Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 30,),
                     // Row(
                     //   mainAxisAlignment: MainAxisAlignment.center,
                     //   children: [
                     //     GestureDetector(
                     //       onTap: (){
                     //         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const AdmissionQueryPage()));
                     //       },
                     //       child: Container(
                     //           child:Lottie.asset('assets/animations/admission open anim.json',
                     //               width: 150,
                     //               height: 150)
                     //       ),
                     //     ),
                     //   ],
                     // ),
                      Container(
                        constraints:const BoxConstraints(
                          maxWidth: 500,
                          maxHeight: 600
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child:isLoginPage?buildLoginCard():buildSignupCard(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if(_isLoading)
                Container(
                  height: 700,
                  width: 500,
                  color: Colors.blue.withOpacity(0.2),
                  child: Center(
                    // child: CircularProgressIndicator(
                    //   color: AppColors.primaryColor,
                    // ),
                    child: Lottie.asset('assets/animations/Loader.json',
                        width: 150,
                        height: 150),
                  ),
                ),
            ],
          ),
        )
    );
  }
}


