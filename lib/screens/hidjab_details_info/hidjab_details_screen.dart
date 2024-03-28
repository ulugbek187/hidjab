import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../data/models/hidjab_model.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/images/app_images.dart';
import '../../utils/styles/app_text_style.dart';
import '../../view_models/books_view_model.dart';
import '../edit_hidjab/edit_book_screen.dart';

class HidjabInfoScreen extends StatelessWidget {
  const HidjabInfoScreen({
    super.key,
    required this.bookModel,
  });

  final HidjabModel bookModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                "Detail Hidjab",
                style: AppTextStyle.interMedium.copyWith(
                  fontSize: 20.sp,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditBookScreen(
                          bookModel: bookModel,
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.blue,
                    size: 24.w,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: AppColors.white,
                          title: const Text("Ishonchingiz komilmi?"),
                          titleTextStyle:
                          AppTextStyle.interBold.copyWith(
                            color: AppColors.black,
                            fontSize: 20.sp,
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                context
                                    .read<BooksViewModel>()
                                    .deleteProduct(
                                    bookModel.docId, context);
                                Future.delayed(
                                  const Duration(seconds: 1),
                                );
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "SUCCESS",
                                    ),
                                  ),
                                );
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Yes',
                                style: AppTextStyle.interBold.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'No',
                                style: AppTextStyle.interBold
                                    .copyWith(color: AppColors.black),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 24.w,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            AppImages.back,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 30.h),

                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 360.h,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SvgPicture.asset(
                                AppImages.shelf,
                              ),
                            ),
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6.r),
                                child: CachedNetworkImage(
                                  imageUrl: bookModel.imageUrl,
                                  height: 300.h,
                                  width: 200.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Text(
                        "Hidjab name:",
                        style: AppTextStyle.interSemiBold.copyWith(
                          color: AppColors.c0F0F10,
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        bookModel.bookName,
                        style: AppTextStyle.interSemiBold.copyWith(
                          color: AppColors.c0F0F10.withOpacity(
                            0.5,
                          ),
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Description:",
                        style: AppTextStyle.interSemiBold.copyWith(
                          color: AppColors.c0F0F10,
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        bookModel.bookDescription,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.interMedium.copyWith(
                          color: AppColors.c9D9EA8,
                          fontSize: 13.sp,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 50.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hidjab reytingi:",
                              style: AppTextStyle.interSemiBold.copyWith(
                                color: AppColors.c0F0F10,
                                fontSize: 16.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  bookModel.rate,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.interMedium.copyWith(
                                    color: AppColors.c9D9EA8,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 20.w,
                                  color: Colors.yellowAccent,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 50.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hidjab narxi:",
                              style: AppTextStyle.interSemiBold.copyWith(
                                color: AppColors.c0F0F10,
                                fontSize: 16.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${bookModel.price} so'm",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.interMedium.copyWith(
                                color: AppColors.c9D9EA8,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
