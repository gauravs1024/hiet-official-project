import 'package:flutter/material.dart';
import 'package:hiet_official_project/Pages/LoginPage.dart';
import 'package:hiet_official_project/SharedPreferences/SharedPreferencesSession.dart';
import '../Utils/AppColors.dart';

class AppDrawerMenuScreen extends StatefulWidget{
  const AppDrawerMenuScreen({super.key});
  @override
  State<AppDrawerMenuScreen> createState()=>_AppDrawerMenuScreenState();
 
}
class _AppDrawerMenuScreenState extends State<AppDrawerMenuScreen>{
   Map<String, String?> userData={};
  // UserSharedPreferences pref=UserSharedPreferences();

   getUserDetails()async{
     UserSharedPreferences userSharedPreferences=UserSharedPreferences();
     userData=await userSharedPreferences.loadUserData();
     setState(() {

     });
     print(userData);
   }



@override
  void initState() {
    super.initState();
    getUserDetails();
  }
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 250,
        color: Colors.white,
        child: ListView(padding: EdgeInsets.zero,
        children:<Widget> [
           DrawerHeader(
              decoration: BoxDecoration(
              color: AppColors.primaryColor
            ),
            padding: const EdgeInsets.fromLTRB(10, 15, 0, 5),
              child:Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,

                  children:<Widget>[
                    const SizedBox(height: 65,),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 8, 0, 5),
                      child:  Text(userData['name']??'Not Available',
                        style:TextStyle(fontSize: 16,color:AppColors.textColorWhite)
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                      child:  Text(
                        '${userData['email']??'Not Available'}',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textColorWhite,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
          ),
          // SizedBox(height: 10,),
          ExpansionTile(
            leading: Icon(Icons.phone,color: AppColors.primaryColor,),
            title: const Text('Contact us'),
            children:<Widget> [
             ListTile(
               title: const Text('1800-1233-123',
                 style: TextStyle(fontSize: 15,color: Colors.black),
               ),
               leading:Icon(Icons.phone_android,color: AppColors.primaryColor,),
               onTap: ()  {

               },
             ),
              ListTile(
                title: const Text('bitcoders_service@gmail.com',
                  style: TextStyle(fontSize: 15,color: Colors.black),
                ),
                leading: Icon(Icons.mail,color: AppColors.primaryColor,),
                onTap: ()  {

                },
              ),
            ],
          ),
          Divider(height: 1,color: AppColors.borderColor,),

          ListTile(
            leading: Icon(Icons.person,color: AppColors.primaryColor,),
            title: const Text('Profile'),
            onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserProfileScreen()));
            },),

          Divider(height: 1,color: AppColors.borderColor,),
          ListTile(
            leading: Icon(Icons.info_outline,color: AppColors.primaryColor,),
            title: const Text('About us'),
          onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutUs()));
          },),

          Divider(height: 1,color: AppColors.borderColor,),

          ListTile(
            leading: Icon(Icons.share,color: AppColors.primaryColor,),
            title: const Text('Share'),
            onTap: (){},),

          Divider(height: 1,color: AppColors.borderColor,),

          ListTile(
            leading: Icon(Icons.security,color: AppColors.primaryColor,),
            title: const Text('Change Password'),
            onTap: (){

            },),

          Divider(height: 1,color: AppColors.borderColor,),
          ListTile(
            leading: Icon(Icons.logout,color: AppColors.primaryColor,),
            title: const Text('Logout'),
            onTap: (){
              // pref.clearUserData();
              UserSharedPreferences pref=UserSharedPreferences();
              pref.clearUserData();

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
            },),

        ],),
      ),
    );
  }
}
