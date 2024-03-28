import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../data/models/category_model.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/styles/app_text_style.dart';
import '../../view_models/category_view_model.dart';
import '../../view_models/notifications_view_model.dart';

class EditCategoryScreen extends StatefulWidget {
  const EditCategoryScreen({
    super.key,
    required this.categoryModel,
  });

  final CategoryModel categoryModel;

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  @override
  void dispose() {
    categoryNameController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String categoryName = '';
    String imageUrl = '';
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: ZoomTapAnimation(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.black,
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.white,
          title: Text(
            "EDIT CATEGORY",
            style: AppTextStyle.interBold.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onChanged: (v) {
                  categoryName = v;
                },
                controller: categoryNameController,
                decoration: InputDecoration(
                  label: const Text(
                    "CATEGORY NAME",
                  ),
                  labelStyle: AppTextStyle.interBold.copyWith(
                    fontSize: 10.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      16.r,
                    ),
                    borderSide: BorderSide(
                      color: Colors.black54,
                      width: 2.w,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      16.r,
                    ),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.w,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      16.r,
                    ),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.w,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              TextFormField(
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                onChanged: (v) {
                  imageUrl = v;
                },
                controller: imageUrlController,
                decoration: InputDecoration(
                  label: const Text(
                    "IMAGE URL",
                  ),
                  labelStyle: AppTextStyle.interBold.copyWith(
                    fontSize: 10.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      16.r,
                    ),
                    borderSide: BorderSide(
                      color: Colors.black54,
                      width: 2.w,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      16.r,
                    ),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.w,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      16.r,
                    ),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.w,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              ZoomTapAnimation(
                onTap: () async {
                  CategoryModel category = CategoryModel(
                    imageUrl: imageUrl == ""
                        ? widget.categoryModel.imageUrl
                        : imageUrl,
                    categoryName: categoryName == ""
                        ? widget.categoryModel.categoryName
                        : categoryName,
                    docId: widget.categoryModel.docId,
                  );
                  await context
                      .read<CategoriesViewModel>()
                      .updateCategory(category, context);
                  if (!context.mounted) return;
                  context.read<NotificationsViewModel>().showNotifications(
                        title:
                            "${categoryNameController.text} NOMLI KATEGORIYA TAHRIRLANDI!!!",
                        body: categoryNameController.text,
                        id: DateTime.now().millisecond,
                      );
                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 30.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(
                      16.r,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "SAVE",
                      style: AppTextStyle.interBold.copyWith(
                        color: AppColors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
