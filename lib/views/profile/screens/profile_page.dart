import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../configs/app_strings.dart';
import '../../../controllers/authentication_controller.dart';
import '../../../packages/flux/styles/shadow.dart';
import '../../../packages/flux/widgets/card/card.dart';
import '../../../packages/flux/widgets/container/container.dart';
import '../../../packages/flux/widgets/text/text.dart';

class ProfileScreen extends StatefulWidget {
  final String title;
  const ProfileScreen({Key? key, this.title = AppStrings.profile}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late ThemeData themeData;
  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Scaffold(
     appBar: AppBar(
        title: Text(widget.title),
        centerTitle: false,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              IconButton(
                onPressed: () {
                  AuthenticationController().logout(context: context);
                },
                icon: Icon(Icons.logout,color: themeData.primaryColor,),
              ),
              Center(
                child: Column(
                  children: [
                    FxContainer(
                      onTap: () {
                      },
                      color: Colors.transparent,
                      paddingAll: 0,
                      borderRadiusAll: 4,
                      height: 100,
                      width: 100,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            child: CachedNetworkImage(
                              height: 100,
                              width: 100,
                              imageUrl: noUserImageUrl,
                              fit: BoxFit.fill,
                              placeholder: (context, _) {
                                return Shimmer.fromColors(
                                  baseColor: themeData.scaffoldBackgroundColor,
                                  highlightColor: themeData.backgroundColor,
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: themeData.secondaryHeaderColor,
                                    child: Icon(
                                      Icons.image,
                                      size: 40,
                                    ),
                                  ),
                                );
                              },
                              errorWidget: (___, __, _) {
                                return Container(
                                  color: Colors.grey[200],
                                  child: Icon(
                                    Icons.image_outlined,
                                    color: Colors.grey[400],
                                    size: 20,
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: FxCard(
                              shadow: FxShadow(elevation: 2),
                              paddingAll: 2,
                              borderRadiusAll: 4,
                              clipBehavior: Clip.none,
                              child: FxContainer(
                                paddingAll: 4,
                                borderRadiusAll: 4,
                                color: themeData.primaryColor.withOpacity(.3),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 16,
                                  color: themeData.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    FxText.bodyLarge(
                      'Dr. Grey',
                      fontWeight: 700,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              FxText.bodyLarge("About",fontWeight: 700,),
              FxText.bodySmall("jadkhaesf jagefuhsef ajfeuzshdf ajbedeizse jabefizse HIUR   JHSDFKJ asdhfihse ajbedi ajdbfi aifdei jbdfi",),

            ]
        ),
      ),
    );
  }
}
