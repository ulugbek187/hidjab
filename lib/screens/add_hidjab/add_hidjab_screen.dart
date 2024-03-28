import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidjab/screens/add_hidjab/widgets/category_button.dart';
import 'package:hidjab/view_models/image_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../data/api_provider/api_provider.dart';
import '../../data/models/category_model.dart';
import '../../data/models/hidjab_model.dart';
import '../../services/local_notification_service.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/styles/app_text_style.dart';
import '../../view_models/books_view_model.dart';
import '../../view_models/category_view_model.dart';
import '../../view_models/notifications_view_model.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookDescriptionController =
      TextEditingController();

  // final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController rateController = TextEditingController();

  @override
  void dispose() {
    bookNameController.dispose();
    // imageUrlController.dispose();
    super.dispose();
  }

  String categoryDocId = '';
  int activeIndex = -1;
  String fcmToken = "";

  void init() async {
    fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    debugPrint("FCM TOKEN:$fcmToken");
    final token = await FirebaseMessaging.instance.getAPNSToken();
    debugPrint("getAPNSToken : ${token.toString()}");
    LocalNotificationService.localNotificationService;
    //Foreground
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage remoteMessage) {
        if (remoteMessage.notification != null) {
          LocalNotificationService().showNotification(
            title: remoteMessage.notification!.title!,
            body: remoteMessage.notification!.body!,
            id: DateTime.now().second.toInt(),
          );

          debugPrint(
              "FOREGROUND NOTIFICATION:${remoteMessage.notification!.title}");
        }
      },
    );
    //Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      debugPrint("ON MESSAGE OPENED APP:${remoteMessage.notification!.title}");
    });
    // Terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint("TERMINATED:${message.notification?.title}");
      }
    });
  }

  @override
  void initState() {
    init();
    super.initState();
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
              color: AppColors.black,
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.green,
          title: Text(
            "ADD Hidjab",
            style: AppTextStyle.interBold.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            bottom: 20.h,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              controller: bookNameController,
                              decoration: InputDecoration(
                                label: const Text(
                                  "HIDJAB NAME",
                                ),
                                labelStyle: AppTextStyle.interBold.copyWith(
                                  fontSize: 10.sp,
                                ),
                                filled: true,
                                fillColor: Colors.white,
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
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              controller: bookDescriptionController,
                              decoration: InputDecoration(
                                label: const Text(
                                  "HIDJAB DESCRIPTION",
                                ),
                                labelStyle: AppTextStyle.interBold.copyWith(
                                  fontSize: 10.sp,
                                ),
                                filled: true,
                                fillColor: Colors.white,
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
                            // TextFormField(
                            //   keyboardType: TextInputType.url,
                            //   textInputAction: TextInputAction.next,
                            //   controller: imageUrlController,
                            //   decoration: InputDecoration(
                            //     label: const Text(
                            //       "IMAGE URL",
                            //     ),
                            //     labelStyle: AppTextStyle.interBold.copyWith(
                            //       fontSize: 10.sp,
                            //     ),
                            //     filled: true,
                            //     fillColor: Colors.white,
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(
                            //         16.r,
                            //       ),
                            //       borderSide: BorderSide(
                            //         color: Colors.black54,
                            //         width: 2.w,
                            //       ),
                            //     ),
                            //     errorBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(
                            //         16.r,
                            //       ),
                            //       borderSide: BorderSide(
                            //         color: Colors.red,
                            //         width: 2.w,
                            //       ),
                            //     ),
                            //     focusedErrorBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(
                            //         16.r,
                            //       ),
                            //       borderSide: BorderSide(
                            //         color: Colors.red,
                            //         width: 2.w,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 24.h,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              controller: rateController,
                              decoration: InputDecoration(
                                label: const Text(
                                  "HIDJAB RATE",
                                ),
                                labelStyle: AppTextStyle.interBold.copyWith(
                                  fontSize: 10.sp,
                                ),
                                filled: true,
                                fillColor: Colors.white,
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
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              controller: priceController,
                              decoration: InputDecoration(
                                label: const Text(
                                  "HIDJAB PRICE",
                                ),
                                labelStyle: AppTextStyle.interBold.copyWith(
                                  fontSize: 10.sp,
                                ),
                                filled: true,
                                fillColor: Colors.white,
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
                          ],
                        ),
                      ),
                      Center(
                        child: Text(
                          "PLEASE, SELECT CATEGORY:",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.interBold.copyWith(
                            color: AppColors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: StreamBuilder<List<CategoryModel>>(
                          stream: context
                              .read<CategoriesViewModel>()
                              .listenCategories(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(snapshot.error.toString()),
                              );
                            }
                            if (snapshot.hasData) {
                              List<CategoryModel> list =
                                  snapshot.data as List<CategoryModel>;
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ...List.generate(
                                    list.length,
                                    (index) => CategoryButton(
                                      title: list[index].categoryName,
                                      onTap: () {
                                        debugPrint(
                                            "\$\$\$\$\$\$\$\$\$========\n$activeIndex\n========\$\$\$\$\$\$\$\$\$");
                                        categoryDocId = list[index].docId;
                                        debugPrint(categoryDocId);
                                        setState(() {
                                          activeIndex = index;
                                        });
                                      },
                                      isActive: activeIndex == index,
                                    ),
                                  )
                                ],
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50.w),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(24),
                              backgroundColor: Colors.black,
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
                      imageUrl == ''
                          ? Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 50.h,
                              ),
                            )
                          : Center(
                              child: Image.network(
                                imageUrl,
                                height: 200.h,
                                width: 200.w,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              ZoomTapAnimation(
                onTap: () async {
                  if (priceController.text != "" &&
                      imageUrl != "" &&
                      bookDescriptionController.text != '' &&
                      bookNameController.text != '' &&
                      categoryDocId != '' &&
                      rateController.text != '') {
                    HidjabModel category = HidjabModel(
                      price: double.parse(priceController.text),
                      imageUrl: imageUrl,
                      rate: rateController.text,
                      bookName: bookNameController.text,
                      docId: "",
                      bookDescription: bookDescriptionController.text,
                      categoryId: categoryDocId,
                    );
                    String messageId =
                        await ApiProvider().sendNotificationToUsers(
                      fcmToken: fcmToken,
                      title: bookNameController.text,
                      body: bookDescriptionController.text,
                      imageUrl: imageUrl,
                      description: bookDescriptionController.text,
                      bookName: bookNameController.text,
                      bookPrice: priceController.text,
                      bookRate: rateController.text,
                      categoryDocId: categoryDocId,
                      topicName: "news",
                    );
                    debugPrint("MESSAGE ID:$messageId");
                    if (!context.mounted) return;
                    await context
                        .read<BooksViewModel>()
                        .insertProducts(category, context);
                    if (!context.mounted) return;
                    Navigator.pop(context);
                    if (!context.mounted) return;
                    context.read<NotificationsViewModel>().showNotifications(
                          title:
                              "${bookNameController.text} NOMLI YANGI KITOB QO'SHILDI!!!",
                          body: bookDescriptionController.text,
                          id: DateTime.now().millisecond,
                        );
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
