import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginapi/Validate.dart';
import 'package:loginapi/custom_text_field.dart';
import 'package:loginapi/data/sources/local/shared_preference/shared_preference.dart';
import 'package:loginapi/screen/forgot_password.dart';
import 'package:loginapi/screen/home.dart';
import 'package:loginapi/screen/login.dart';
import 'package:loginapi/screen/login_viewmodel.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  //===================== global key =====================
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  //============================ controller ==========================
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body:Form(
            key:_formKey,
            child: Column(
              children: [
                Container(
                  height:200.h,
                  width:double.maxFinite,
                  decoration:BoxDecoration(
                      color:Colors.teal,
                      borderRadius:BorderRadius.only(
                          bottomLeft:Radius.circular(20.r),
                          bottomRight:Radius.circular(20.r)
                      )
                  ),
                ),
                SizedBox(height:40.h),
                Text("Sign in",style:TextStyle(fontSize:25.sp,fontWeight:FontWeight.w900,color:Colors.teal),),
                SizedBox(height:30.h),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal:20.w),
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text("Email",style:TextStyle(fontSize:18.sp,fontWeight:FontWeight.w600,color:Colors.teal),),
                      SizedBox(height:10.h),
                      CustomFromField(
                        validator:emailValidator,
                        controller:emailController,
                      ),
                      SizedBox(height:10.h),
                      Text("Mot de passe",style:TextStyle(fontSize:18.sp,fontWeight:FontWeight.w600,color:Colors.teal),),
                      SizedBox(height:10.h),
                      CustomFromField(
                        validator:passwordValidator,
                        controller:passwordController,
                      ),
                      Align(alignment:Alignment.centerRight, child: TextButton(onPressed:(){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ForgotPassword(),
                        ),
                        );}, child:Text("Forgot Password?",style:TextStyle(fontSize:13.sp,color:Colors.red)))),
                      SizedBox(height:10.h),
                      GestureDetector(
                        onTap:()async{
                          if(_formKey.currentState!.validate()){
                            final fcmToken =
                            await SharedPreferenceData.getFcmToken();
                            final res = await ref
                                .read(userLoginProvider.notifier)
                                .signUp(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              fcm_token: fcmToken ?? 'dummy_token',
                              platform: Platform.isAndroid ? 'ANDROID' : 'IOS',
                            );
                            if (res.isSuccess) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ),
                              );
                            } else {}
                          }
                        },
                        child: Container(
                          alignment:Alignment.center,
                          height:46.h,
                          width:double.maxFinite,
                          decoration:BoxDecoration(
                              color:Colors.teal,
                              borderRadius:BorderRadius.circular(4.r)
                          ),
                          child:Text("Sign In",style:TextStyle(fontSize:18.sp,fontWeight:FontWeight.w600,color:Colors.white),),
                        ),
                      ),
                      Row(
                        children: [
                          Text("Don't have an account?",style:TextStyle(fontSize:12.sp,color:Colors.black),),
                          TextButton(onPressed:(){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                            );
                          }, child:Text("Log in",style:TextStyle(fontSize:15.sp,color:Colors.teal)))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
