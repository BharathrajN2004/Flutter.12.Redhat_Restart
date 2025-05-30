import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/common/icon.dart';

import '../../utilities/theme/color_data.dart';
import '../../utilities/theme/size_data.dart';

class CustomBackButton extends ConsumerWidget {
  final Function? method;
  final Function? otherMethod;
  final Widget? tomove;
  const CustomBackButton(
      {super.key, this.method, this.tomove, this.otherMethod});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomSizeData sizeData = CustomSizeData.from(context);
    CustomColorData colorData = CustomColorData.from(ref);

    double aspectRatio = sizeData.aspectRatio;

    return GestureDetector(
      onTap: () {
        // tomove != null
        //     ? Navigator.push(
        //         context, MaterialPageRoute(builder: (context) => tomove!))
        //     : Navigator.pop(context);
        Navigator.pop(context);
        method != null ? method!(ref) : null;
        otherMethod != null ? otherMethod!() : null;
      },
      child: Container(
        padding: EdgeInsets.all(aspectRatio * 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: colorData.primaryColor(1),
        ),
        child: CustomIcon(
          icon: Icons.arrow_back_ios_new_rounded,
          color: colorData.sideBarTextColor(.85),
          size: aspectRatio * 55,
        ),
      ),
    );
  }
}
