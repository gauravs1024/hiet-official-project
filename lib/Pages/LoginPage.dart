
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import '../API/Api.dart';
import '../SharedPreferences/SharedPreferencesSession.dart';
import '../Utils/AppColors.dart';
import '../Utils/CustomWidgets.dart';
import 'HomePage.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading=false;
  }

  @override
  void dispose(){
    nameController.dispose();
    passwordController.dispose();
    emailPhoneController.dispose();
    confirmPasswordController.dispose();
    super.dispose();

  }

  void clearFields(){
    emailPhoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
  }


  Future<void> saveSession(String name,String userId,String userRole,String email,String isLoggedIn) async {
    // FlutterSecureStorage secureStorage=const FlutterSecureStorage();
    // SessionManagement sessionManagement=SessionManagement();
    // await sessionManagement.saveSession(name, userId, userRole, isLoggedIn);

    UserSharedPreferences userSharedPreferences=UserSharedPreferences();
    await userSharedPreferences.saveUserData(name, userId, userRole, email, isLoggedIn);
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
        if(responseMsg['status']==true){
        await  saveSession(responseMsg['data']['name'],responseMsg['data']['id'].toString(),responseMsg['data']['role'],
              responseMsg['data']['email'],(DateTime.now()).toString());
          clearFields();
          Navigator.push(context,MaterialPageRoute(builder: (_)=>const HomePage()));
        }
        else{
          _isLoading=false;
          CustomWidgets.showQuickAlert(responseMsg['message'],'error' , context);
        }
      }

  }
  catch(e){
  print('Exception thrown    $e');
  CustomWidgets.showQuickAlert('Server Error','error' , context);
  _isLoading=false;
  }
  finally{
  _isLoading=false;
  setState(() {

  });
  }
}
    void inputTextValidation(){
    if(emailPhoneController.text==''){
      CustomWidgets.showQuickAlert('Please fill all the fields','error',context );


    }
    else if(passwordController.text==''){
      CustomWidgets.showQuickAlert('Please fill all the fields','error',context);
    }
    else{
      userLogin();
    }
    }







  // Widget showDialog(){
  //   return AlertDialog(
  //     title: const Text('AlertDialog Title'),
  //     content: const Text('AlertDialog description'),
  //     actions: <Widget>[
  //       TextButton(
  //         onPressed: () => Navigator.pop(context, 'Cancel'),
  //         child: const Text('Cancel'),
  //       ),
  //       TextButton(
  //         onPressed: () => Navigator.pop(context, 'OK'),
  //         child: const Text('OK'),
  //       ),
  //     ],
  //   );
  //
  //   }




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


           CustomWidgets.buildTextFormField('Email or Phone number',emailPhoneController),


            Container(
              padding: const EdgeInsets.all(8.0),
              decoration:  BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.borderColor))
              ),
              child: TextFormField(
                controller: passwordController,
                  obscureText: _isObscured,
                  style:  TextStyle(color:AppColors.primaryTextColor,fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.borderColor,width: 2.0),),
                      labelText: 'Password ',
                      labelStyle:  TextStyle(color: AppColors.primaryTextColor,fontWeight: FontWeight.bold),
                      suffixIcon: IconButton( icon:
                      Icon(_isObscured ?Icons.visibility:Icons.visibility_off,),
                        onPressed: _togglePasswordVisibilty,
                      )
                  )
              ),
            ),

            const SizedBox(height: 10,),

            CustomWidgets.customButton('Login', inputTextValidation),
             Row(mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 GestureDetector(
                   onTap: (){},
                   child: const Text("Forgot Password?",
                       style: TextStyle(color:Color.fromRGBO(1, 10, 174, 1.0), fontWeight: FontWeight.bold)),
                 ),
                 TextButton(onPressed: (){
                   isLoginPage=false;
                   clearFields();
                   setState(() {

                   });
                 }, child: const Text("Signup",
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
              height: 120,
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

            CustomWidgets.buildTextFormField('Name',nameController),
            CustomWidgets.buildTextFormField('Email or Phone number',emailPhoneController),


            Container(
              padding: const EdgeInsets.all(8.0),
              decoration:  BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.borderColor))
              ),
              child: TextFormField(
                  obscureText: _isObscured,
                  style:  TextStyle(color:AppColors.borderColor,fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.borderColor,width: 2.0),),
                      labelText: 'Password ',
                      labelStyle:  TextStyle(color: AppColors.primaryTextColor,fontWeight: FontWeight.bold),

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
                  style:  TextStyle(color: AppColors.borderColor,fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.borderColor,width: 2.0),),
                      labelText: 'Confirm Password ',
                      labelStyle: TextStyle(color: AppColors.primaryTextColor,fontWeight: FontWeight.bold),
                      suffixIcon: IconButton( icon:
                      Icon(_isObscured ?Icons.visibility:Icons.visibility_off,),
                        onPressed: _togglePasswordVisibilty,
                      )
                  )
              ),
            ),


            const SizedBox(height: 10,),
            CustomWidgets.customButton('SignUp', inputTextValidation),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextButton(onPressed: (){
                isLoginPage=true;
                clearFields();
                setState(() {

                });
              }, child: const Text("Already Registered? Login",
                  style: TextStyle(color: Color.fromRGBO(1, 10, 174, 1.0), fontWeight: FontWeight.bold))
              ),
            ),
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
                      const SizedBox(height: 30,),
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


