import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_select_provider.dart';
import '../utilities/theme/theme_provider.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/user_detail_provider.dart';
import '../components/profile/color_palette.dart';
import '../components/profile/theme_toggle.dart';
import '../functions/firebase_auth.dart';
import '../utilities/static_data.dart';
import '../utilities/theme/color_data.dart';
import '../utilities/theme/size_data.dart';

import '../components/common/back_button.dart';
import '../components/common/text.dart';
import '../components/profile/profile_tile.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, dynamic> userData = ref.watch(userDataProvider)!;
    UserRole role = ref.watch(userRoleProvider)!;
    CustomSizeData sizeData = CustomSizeData.from(context);
    CustomColorData colorData = CustomColorData.from(ref);

    double height = sizeData.height;
    double width = sizeData.width;
    double aspectRatio = sizeData.aspectRatio;
    Map<ThemeMode, Color> themeMap = ref.watch(themeProvider);
    ThemeProviderNotifier notifier = ref.read(themeProvider.notifier);

    bool isDark = themeMap.keys.first == ThemeMode.dark;

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: width * 0.04,
            right: width * 0.04,
            top: height * 0.02,
          ),
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return ShaderMask(
                shaderCallback: (rect) {
                  return RadialGradient(
                    radius: value * 5,
                    center: FractionalOffset(0, 1),
                    stops: [0.0, 0.5, 0.7, 1.0],
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.transparent,
                      Colors.transparent
                    ],
                  ).createShader(rect);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomBackButton(),
                        ThemeToggle(),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    role != UserRole.student
                        ? Container(
                            padding: EdgeInsets.all(aspectRatio * 8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorData.secondaryColor(1),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(width),
                              child: Image.network(userData["photo"],
                                  height: aspectRatio * 250,
                                  width: aspectRatio * 250,
                                  fit: BoxFit.cover, loadingBuilder:
                                      (BuildContext context, Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Shimmer.fromColors(
                                    baseColor: colorData.backgroundColor(.1),
                                    highlightColor:
                                        colorData.secondaryColor(.1),
                                    child: Container(
                                      height: aspectRatio * 250,
                                      width: aspectRatio * 250,
                                      decoration: BoxDecoration(
                                        color: colorData.secondaryColor(.5),
                                        borderRadius:
                                            BorderRadius.circular(width),
                                      ),
                                    ),
                                  );
                                }
                              }),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(height: height * 0.02),
                    CustomText(
                      text: userData["name"],
                      size: sizeData.header,
                      weight: FontWeight.w800,
                      color: colorData.fontColor(.8),
                    ),
                    SizedBox(height: height * 0.005),
                    CustomText(
                      text: userData["email"],
                      size: sizeData.regular,
                      color: colorData.fontColor(.6),
                    ),
                    SizedBox(height: height * 0.05),
                    const ColorPalette(),
                    ProfileTile(
                        text: 'Edit Profile',
                        icon: Icons.edit_outlined,
                        todo: () {}),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    ProfileTile(
                        text: 'Help',
                        icon: Icons.help_outline_outlined,
                        todo: () {}),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    ProfileTile(
                        text: 'History', icon: Icons.history, todo: () {}),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    ProfileTile(
                      text: 'Logout',
                      icon: Icons.logout_outlined,
                      todo: () {
                        AuthFB().signOut();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
