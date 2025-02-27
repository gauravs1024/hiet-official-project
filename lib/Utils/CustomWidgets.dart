import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiet_official_project/Utils/AppColors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class CustomWidgets{

 static customAppBAr(String title,){
   return AppBar(
       centerTitle: true,
       backgroundColor: AppColors.primaryColor,
       title: Text(title,
         style: TextStyle(color:AppColors.secondaryTextColor),
       ),
   );
 }
 static  customButton( String btnText,VoidCallback onPressed){
    return  AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 30.0,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child:  Center(
            child: Text(btnText,
              style: const TextStyle(
                color: Color(0xffffffff),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
 }

 static customVisitorCard(
     String name,String email,String purpose,
     String phone,String alternatePhone,
     String contactPerson,String address,
     String date,
     VoidCallback onTapEditIcon
     ){
   return  Card(
     margin: EdgeInsets.symmetric(vertical: 10),
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(16.0),
       side:  BorderSide(
              color:AppColors.borderColor
              ),
     ),
     elevation: 5,
     color: Colors.white,
     shadowColor: Colors.black.withOpacity(0.1),
     child: Container(
       // decoration: BoxDecoration(border: Border.all()),
       child: Stack(
         children: [
           Positioned(
             top: 100,
             left: 105,
             height: 100,
             width: 100,
             child: Opacity(
               opacity: 0.2,
               child: Image.asset('assets/images/hiet-logo-clear-background.png',
                 fit: BoxFit.fill,
               ),
             ),
           ),

           Padding(
             padding: const EdgeInsets.all(10.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [

                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Row(
                       children: [
                         Icon(Icons.person, color:AppColors.primaryColor),
                         SizedBox(width: 8),
                         Text("Name: $name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                       ],
                     ),
                     IconButton(onPressed: onTapEditIcon, icon: Icon(Icons.edit))
                   ],

                 ),
                 Divider(),
                 Row(
                   children: [
                     Icon(Icons.email, color: AppColors.primaryColor),
                     SizedBox(width: 8),
                     Text("Email: $email", style: TextStyle(fontSize: 16)),
                   ],
                 ),
                 Divider(),
                 Row(
                   children: [
                     Icon(Icons.person_search_rounded, color: AppColors.primaryColor),
                     SizedBox(width: 8),
                     Text("Purpose: $purpose", style: TextStyle(fontSize: 16)),
                   ],
                 ),


                 Divider(),
                 Row(
                   children: [
                     Icon(Icons.phone, color: AppColors.primaryColor),
                     SizedBox(width: 8),
                     Text("Phone: $phone", style: TextStyle(fontSize: 16)),
                   ],
                 ),
                 Divider(),
                 Row(
                   children: [
                     Icon(Icons.phone_iphone, color: AppColors.primaryColor),
                     SizedBox(width: 8),
                     Text("Alternate Phone: $alternatePhone", style: TextStyle(fontSize: 16)),
                   ],
                 ),
                 Divider(),
                 Row(
                   children: [
                     Icon(Icons.contact_phone, color: AppColors.primaryColor),
                     SizedBox(width: 8),
                     Text("Contact Person: $contactPerson", style: TextStyle(fontSize: 16)),
                   ],
                 ),
                 Divider(),
                 Row(
                   children: [
                     Icon(Icons.location_on, color: AppColors.primaryColor),
                     SizedBox(width: 8),
                     Text("Address: $address", style: TextStyle(fontSize: 16)),
                   ],
                 ),
                 Divider(),
                 Row(
                   children: [
                     Icon(Icons.calendar_today, color: AppColors.primaryColor),
                     SizedBox(width: 8),
                     Text("Date: $date", style: TextStyle(fontSize: 16)),
                   ],
                 ),
               ],
             ),
           ),
         ],
       ),
     ),
   );
 }




  static buildTextFormField(String label, TextEditingController controller) {
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





 static showQuickAlert(String message ,String type,BuildContext context){
   AlertType _type=AlertType.error;
   if(type=='success'){
     _type =AlertType.success;

   }
   else if(type=='warning'){
     _type=AlertType.warning;
   }
   else if(type=='error'){
     _type=AlertType.error;
   }

   Alert(context: context,
       title: message,
       type: _type,
       buttons: [
         DialogButton(child: Text('OKAY',style: TextStyle(color: Colors.white),),
             color: AppColors.primaryColor,
             onPressed: (){
               Navigator.of(context).pop();
             })
       ]
   ).show();
   Future.delayed(const Duration(seconds: 3), () {
     Navigator.of(context).pop(); // Close the alert after 3 seconds
   });

 }

 static Widget customTextRow(String field,String text){
   return Column(
     children: [
       Row(
         children: <Widget>[
           Expanded(
             child: Container(
               // height: 12,
                 margin: EdgeInsets.zero,
                 child: Text(
                   field,
                   textAlign: TextAlign.left,
                   style: TextStyle(
                       fontSize: 12,
                       fontWeight: FontWeight.bold,
                       color: Colors.grey[600]),
                 )),
           ),
           Expanded(
             child: Text(text,
                 textAlign: TextAlign.right, style:const TextStyle(fontSize: 12)),
           ),

         ],
       ),
       const Divider(color: Colors.grey),
     ],
   );
 }

}