import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginapi/Validate.dart';
import 'package:loginapi/custom_text_field.dart';
import 'package:loginapi/screen/home.dart';
import 'package:loginapi/screen/login_viewmodel.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key:_formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Reset the password",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                SizedBox(height:20.h),
                Container(height:1.h,width:double.maxFinite,color:Color(0xffE6E6E6)),
                SizedBox(height:20.h),
                Text(
                  "Enter the email associated with your account, and we will send you an email with instructions to reset your password",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff8A9199),
                  ),
                ),
                SizedBox(height:20.h),
                Text("Email",style:TextStyle(fontSize:16.sp,fontWeight:FontWeight.w500,color:Color(0xff21252C)),),
                SizedBox(height:10.h),
                CustomFromField(
                  controller:emailController,
                  validator:emailValidator,
                ),
                SizedBox(height:20.h),
                GestureDetector(
                  onTap:()async{
                    if(_formKey.currentState!.validate()){
                      final res = await ref.read(userLoginProvider.notifier).forgotPassword(email:emailController.text.trim(),);
                      if(res.isSuccess){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    alignment:Alignment.center,
                    padding:EdgeInsets.all(15.w),
                    width:double.maxFinite,
                    decoration:BoxDecoration(
                        color:Colors.deepOrange,
                        borderRadius:BorderRadius.circular(4.r)
                    ),
                    child:Text("Send",style:TextStyle(fontSize:16.sp,fontWeight:FontWeight.w600,color:Colors.white),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
