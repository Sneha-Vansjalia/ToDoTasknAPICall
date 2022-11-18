import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_task/themedata.dart';
import 'package:to_do_task/userdetail_services.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  var userDataController = Get.put(UserDataController());
  @override
  void initState() {
    userDataController.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeClass.orangeColor,
        elevation: 0,
        title: const Text("User Detail API Call"),
      ),
      body: Obx(
        () => (userDataController.isloading.value == false)
            ? userDataController.isError.value == true
                ? Center(
                    child:
                        Text(userDataController.errorMessage.value.toString()),
                  )
                : RefreshIndicator(
                    color: ThemeClass.orangeColor,
                    onRefresh: () {
                      return userDataController.getUserData();
                    },
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15),
                        child: ListView.builder(
                          itemCount:
                              userDataController.userData.value.data!.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 00.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: CachedNetworkImage(
                                          imageUrl: userDataController.userData
                                              .value.data![index].avatar
                                              .toString(),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover),
                                                borderRadius:
                                                    BorderRadius.circular(200)),
                                          ),
                                          placeholder: (context, url) =>
                                              Container(
                                            height: 50,
                                            width: 50,
                                            child: CircularProgressIndicator(
                                              color: ThemeClass.orangeColor,
                                              strokeWidth: 3,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/default_image.jpg"),
                                                    fit: BoxFit.cover),
                                                borderRadius:
                                                    BorderRadius.circular(200)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${userDataController.userData.value.data![index].firstName} ${userDataController.userData.value.data![index].lastName}",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: ThemeClass.orangeColor,
                                              ),
                                            ),
                                            Text(
                                              userDataController.userData.value
                                                  .data![index].email
                                                  .toString(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 40,
                                    thickness: 1,
                                    color:
                                        ThemeClass.blackColor.withOpacity(0.2),
                                  )
                                ],
                              ),
                            );
                          },
                        )

                        // GridView.builder(
                        //   shrinkWrap: true,
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   gridDelegate:
                        //       const SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 2,
                        //     crossAxisSpacing: 10,
                        //     mainAxisSpacing: 10,
                        //     childAspectRatio: 0.7,
                        //   ),
                        //   itemCount: userDataController
                        //       .userData.value.data!.length,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     return Text(userDataController
                        //         .userData.value.data![index].lastName
                        //         .toString());
                        //   },
                        // ),
                        ),
                  )
            : Container(
                height: height,
                width: width,
                child: Center(
                  child: CircularProgressIndicator(
                    color: ThemeClass.orangeColor,
                  ),
                ),
              ),
      ),
    );
  }
}
