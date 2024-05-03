import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidjab/data/models/category_model.dart';
import 'package:hidjab/utils/colors/app_colors.dart';
import 'package:hidjab/utils/styles/app_text_style.dart';
import 'package:hidjab/view_models/category_view_model.dart';
import 'package:hidjab/view_models/image_view_model.dart';
import 'package:hidjab/view_models/notifications_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  bool imageState = false;
  @override
  void dispose() {
    categoryNameController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.lightGreen,
        appBar: AppBar(
          leading: ZoomTapAnimation(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.white,
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.green,
          title: Text(
            "ADD CATEGORY",
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
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: categoryNameController,
                    decoration: InputDecoration(
                      label: const Text(
                        "CATEGORY NAME",
                      ),
                      filled: true,
                      fillColor: Colors.white,
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
                  imageState == false
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("no photo"),
                      SizedBox(
                        width: 10.w,
                      ),
                      Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 50.h,
                      ),
                    ],
                  )
                      : Center(
                    child: Image.network(
                      imageUrl,
                      height: 485.h,
                      width: 400.w,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.w),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(24),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          takeAnImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "image take",
                              style: AppTextStyle.interSemiBold.copyWith(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.image,
                              color: Colors.white,
                              size: 20.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // const Spacer(),
                  ZoomTapAnimation(
                    onTap: () async {
                      if (categoryNameController.text != "" &&
                          imageUrlController.text != "") {
                        CategoryModel category = CategoryModel(
                          imageUrl: imageUrlController.text,
                          categoryName: categoryNameController.text,
                          docId: "",
                        );
                        await context.read<CategoriesViewModel>().insertCategory(
                              category,
                              context,
                            );
                        if (!context.mounted) return;
                        context.read<NotificationsViewModel>().showNotifications(
                              title:
                                  "${categoryNameController.text} NOMLI YANGI KATEGORIYA QO'SHILDI!!!",
                              body: categoryNameController.text,
                              id: DateTime.now().millisecond,
                            );
                        if (!context.mounted) return;
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "PLEASE COMPLETE ALL DETAILS",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: 30.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
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
        ),
      ),
    );
  }
  final ImagePicker picker = ImagePicker();
  String imageUrl = "";
  String storagePath = "";

  Future<void> _getImageFromCamera() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      if (mounted) {
        imageUrl = (await context.read<ImageViewModel>().uploadImage(
          pickedFile: image,
          storagePath: storagePath,
        ))!;
      }

      debugPrint("DOWNLOAD URL:$imageUrl");
      imageState = true;
      setState(() {});
    }
  }

  Future<void> _getImageFromGallery() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      if (mounted) {
        imageUrl = (await context.read<ImageViewModel>().uploadImage(
          pickedFile: image,
          storagePath: storagePath,
        ))!;
      }
      debugPrint("DOWNLOAD URL:$imageUrl");
      imageState = true;
      setState(() {});
    }
  }

  takeAnImage() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              ListTile(
                onTap: () async {
                  await _getImageFromGallery();

                  if (context.mounted) {
                    Navigator.pop(context);
                    imageState = true;
                    setState(() {});
                  }
                },
                leading: const Icon(Icons.photo_album_outlined),
                title: const Text("Gallereyadan olish"),
              ),
              ListTile(
                onTap: () async {
                  await _getImageFromCamera();
                  if (context.mounted) {
                    Navigator.pop(context);
                    imageState = true;
                    setState(() {});
                  }
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Kameradan olish"),
              ),
              SizedBox(height: 24.h),
            ],
          );
        });
  }
}
