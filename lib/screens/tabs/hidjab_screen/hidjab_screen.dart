import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/hidjab_model.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/styles/app_text_style.dart';
import '../../../view_models/category_view_model.dart';
import '../../../view_models/notifications_view_model.dart';
import '../../../view_models/books_view_model.dart';
import '../../add_hidjab/widgets/category_button.dart';
import '../../edit_hidjab/edit_book_screen.dart';
import '../../hidjab_details_info/hidjab_details_screen.dart';
import '../../routes.dart';

class HidjabScreen extends StatefulWidget {
  const HidjabScreen({super.key});

  @override
  State<HidjabScreen> createState() => _HidjabScreenState();
}

class _HidjabScreenState extends State<HidjabScreen> {
  String categoryDocId = '';

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.1),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.black.withOpacity(0.3),
          title: Text(
            "All Hidjabs",
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
                  RouteNames.addBookRoute,
                );
              },
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: StreamBuilder<List<CategoryModel>>(
                stream: context.read<CategoriesViewModel>().listenCategories(),
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
                        CategoryButton(
                          title: "All",
                          onTap: () {
                            setState(() {
                              activeIndex = -1;
                            });
                            categoryDocId = '';
                          },
                          isActive: activeIndex == -1,
                        ),
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
              height: 10.h,
            ),
            categoryDocId == ''
                ? StreamBuilder<List<HidjabModel>>(
                    stream: context.read<BooksViewModel>().listenProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (snapshot.hasData) {
                        List<HidjabModel> list = snapshot.data as List<HidjabModel>;
                        return Expanded(
                          child: GridView.count(
                            primary: false,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 20.h,
                            ),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            childAspectRatio: 0.5,
                            children: [
                              ...List.generate(
                                list.length,
                                (index) => Container(
                                  padding: EdgeInsets.only(
                                    bottom: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.black,
                                      width: 2.w,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HidjabInfoScreen(
                                                bookModel: list[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: CachedNetworkImage(
                                          imageUrl: list[index].imageUrl,
                                          height: 200.h,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Expanded(
                                        child: Text(
                                          list[index].bookName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ZoomTapAnimation(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditBookScreen(
                                                    bookModel: list[index],
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
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        AppColors.white,
                                                    title: const Text(
                                                      "Ishonchingiz komilmi?",
                                                    ),
                                                    titleTextStyle: AppTextStyle
                                                        .interBold
                                                        .copyWith(
                                                      color: AppColors.black,
                                                      fontSize: 20.sp,
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () async {
                                                          context
                                                              .read<
                                                                  BooksViewModel>()
                                                              .deleteProduct(
                                                                list[index]
                                                                    .docId,
                                                                context,
                                                              );
                                                          if (!context
                                                              .mounted) {
                                                            return;
                                                          }
                                                          context
                                                              .read<
                                                                  NotificationsViewModel>()
                                                              .showNotifications(
                                                                title:
                                                                    "${list[index].bookName} NOMLI YANGI KITOB O'CHIRILDI!!!",
                                                                body: list[
                                                                        index]
                                                                    .bookName,
                                                                id: DateTime
                                                                        .now()
                                                                    .millisecond,
                                                              );
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Yes',
                                                          style: AppTextStyle
                                                              .interBold
                                                              .copyWith(
                                                            color:
                                                                AppColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          'No',
                                                          style: AppTextStyle
                                                              .interBold
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .black),
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
                            ],
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                : StreamBuilder<List<HidjabModel>>(
                    stream: context
                        .read<BooksViewModel>()
                        .listenProductsByCategory(categoryDocId: categoryDocId),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (snapshot.hasData) {
                        List<HidjabModel> list = snapshot.data as List<HidjabModel>;
                        return Expanded(
                          child: GridView.count(
                            primary: false,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 20.h,
                            ),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            childAspectRatio: 0.5,
                            children: [
                              ...List.generate(
                                list.length,
                                (index) => Container(
                                  padding: EdgeInsets.only(
                                    bottom: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.black,
                                      width: 2.w,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HidjabInfoScreen(
                                                bookModel: list[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: CachedNetworkImage(
                                          imageUrl: list[index].imageUrl,
                                          height: 200.h,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Expanded(
                                        child: Text(
                                          list[index].bookName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ZoomTapAnimation(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditBookScreen(
                                                    bookModel: list[index],
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
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        AppColors.white,
                                                    title: const Text(
                                                        "Ishonchingiz komilmi?"),
                                                    titleTextStyle: AppTextStyle
                                                        .interBold
                                                        .copyWith(
                                                      color: AppColors.black,
                                                      fontSize: 20.sp,
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () async {
                                                          context
                                                              .read<
                                                                  BooksViewModel>()
                                                              .deleteProduct(
                                                                list[index]
                                                                    .docId,
                                                                context,
                                                              );
                                                          if (!context
                                                              .mounted) {
                                                            return;
                                                          }
                                                          context
                                                              .read<
                                                                  NotificationsViewModel>()
                                                              .showNotifications(
                                                                title:
                                                                    "${list[index].bookName} NOMLI YANGI KITOB O'CHIRILDI!!!",
                                                                body: list[
                                                                        index]
                                                                    .bookName,
                                                                id: DateTime
                                                                        .now()
                                                                    .millisecond,
                                                              );
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Yes',
                                                          style: AppTextStyle
                                                              .interBold
                                                              .copyWith(
                                                            color:
                                                                AppColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          'No',
                                                          style: AppTextStyle
                                                              .interBold
                                                              .copyWith(
                                                            color:
                                                                AppColors.black,
                                                          ),
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
                            ],
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
