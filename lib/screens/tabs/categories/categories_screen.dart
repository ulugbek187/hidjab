import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data/models/category_model.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/styles/app_text_style.dart';
import '../../../view_models/category_view_model.dart';
import '../../../view_models/notifications_view_model.dart';
import '../../category/category_screen.dart';
import '../../edit_category/edit_category_screen.dart';
import '../../routes.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.1),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.black.withOpacity(0.3),
        centerTitle: true,
        title: Text(
          "Categories",
          style: AppTextStyle.interBold.copyWith(
            color: AppColors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          ZoomTapAnimation(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteNames.addCategoryRoute,
              );
            },
            child: const Icon(
              Icons.add,
              color: AppColors.white,
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<CategoryModel>>(
        stream: context.read<CategoriesViewModel>().listenCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            List<CategoryModel> list = snapshot.data as List<CategoryModel>;
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              children: [
                ...List.generate(
                  list.length,
                  (index) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(
                            categoryModel: list[index],
                            categoryDocId: list[index].docId,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.black,
                          width: 2.w,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: list[index].imageUrl,
                            height: 200.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            list[index].categoryName,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ZoomTapAnimation(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditCategoryScreen(
                                        categoryModel: list[index],
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 50.w,
                              ),
                              ZoomTapAnimation(
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: AppColors.white,
                                        title:
                                            const Text("Ishonchingiz komilmi?"),
                                        titleTextStyle:
                                            AppTextStyle.interBold.copyWith(
                                          color: AppColors.black,
                                          fontSize: 20.sp,
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () async {
                                              context
                                                  .read<CategoriesViewModel>()
                                                  .deleteCategory(
                                                    list[index].docId,
                                                    context,
                                                  );
                                              if (!context.mounted) return;
                                              context
                                                  .read<
                                                      NotificationsViewModel>()
                                                  .showNotifications(
                                                    title:
                                                        "${list[index].categoryName} NOMLI YANGI KATEGORIYA QO'SHILDI!!!",
                                                    body: list[index]
                                                        .categoryName,
                                                    id: DateTime.now()
                                                        .millisecond,
                                                  );
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Yes',
                                              style: AppTextStyle.interBold
                                                  .copyWith(
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
                                                  .copyWith(
                                                      color: AppColors.black),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
