import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../utils/styles/app_text_style.dart';
import '../../view_models/auth_view_model.dart';
import 'widgets/update_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = context.watch<AuthViewModel>().getUser;
    final List<UpdateModel> models = [
      UpdateModel(title: "Name", subTitle: user!.displayName!),
      UpdateModel(title: "Email", subTitle: user.email!),
    ];
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: AppTextStyle.interBold.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              user.photoURL != null
                  ? Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: 30.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            50.r,
                          ),
                          border: Border.all(
                            color: Colors.yellowAccent,
                            width: 2.w,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            50.r,
                          ),
                          child: Image.network(
                            user.photoURL!,
                            width: 150.w,
                            height: 150.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: 30.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            50.r,
                          ),
                          border: Border.all(
                            color: Colors.yellowAccent,
                            width: 2.w,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            50.r,
                          ),
                          child: Image.network(
                            "https://www.tenforums.com/attachments/tutorials/146359d1501443008-change-default-account-picture-windows-10-a-user.png",
                            width: 150.w,
                            height: 150.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
              ...List.generate(
                models.length,
                (index) => UpdateTextField(
                  title: models[index].title,
                  subTitle: models[index].subTitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpdateModel {
  final String title;
  final String subTitle;

  UpdateModel({
    required this.title,
    required this.subTitle,
  });
}
