import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidjab/screens/auth_login/widgets/my_text_field.dart';
import 'package:provider/provider.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/images/app_images.dart';
import '../../utils/styles/app_text_style.dart';
import '../../view_models/auth_view_model.dart';
import '../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: context.watch<AuthViewModel>().loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 24.h,
                ),
                child: ListView(
                  children: [
                    Image.asset(AppImages.login, height: 165.h,width: 200.w,),
                    Text(
                      "LOGIN",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.interSemiBold.copyWith(
                        fontSize: 32.sp,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    MyTextField(
                      onChanged: (v) {},
                      controller: emailController,
                      hinText: "Email",
                      type: TextInputType.text,
                      iconPath: AppImages.email,
                      regExp: AppConstants.emailRegExp,
                      errorText: 'Emailni togri kiriting',
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    MyTextField(
                      onChanged: (v) {},
                      type: TextInputType.text,
                      iconPath: AppImages.lock,
                      hinText: 'Password',
                      regExp: AppConstants.passwordRegExp,
                      errorText: 'Kodni togri kiriting',
                      controller: passwordController,
                    ),
                    Container(
                      height: 60.h,
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: 24.h,
                        left: 24.w,
                        right: 24.w,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              16.r,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          await context.read<AuthViewModel>().loginUser(
                                context,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                        },
                        child: Text(
                          "LOGIN",
                          style: AppTextStyle.interSemiBold.copyWith(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 60.h,
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: 24.h,
                        left: 24.w,
                        right: 24.w,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              16.r,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RouteNames.registerRoute,
                          );
                        },
                        child: Text(
                          "REGISTER",
                          style: AppTextStyle.interSemiBold.copyWith(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 60.h,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 24.h,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              16.r,
                            ),
                          ),
                        ),
                        onPressed: () {
                          context.read<AuthViewModel>().signInWithGoogle(
                                context,
                                Platform.isAndroid
                                    ? null
                                    : AppConstants.clientID,
                              );
                        },
                        child: Text(
                          "LOGIN WITH GOOGLE",
                          style: AppTextStyle.interSemiBold.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
