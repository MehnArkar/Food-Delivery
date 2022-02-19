import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class AppColum extends StatelessWidget {
  final String text;
  const AppColum({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimension.fontsize26,
        ),
        SizedBox(
          height: Dimension.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                  (index) => Icon(
                        Icons.star,
                        color: AppColors.mainColor,
                        size: Dimension.icon24,
                      )),
            ),
            SizedBox(
              width: 10,
            ),
            SmallText(text: '4.5'),
            SizedBox(
              width: 10,
            ),
            SmallText(text: '1287'),
            SizedBox(
              width: 5,
            ),
            SmallText(text: 'comments'),
          ],
        ),
        SizedBox(
          height: Dimension.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(
                icon: Icons.circle_sharp,
                text: 'Normal',
                iconColor: AppColors.iconColor1),
            IconAndText(
                icon: Icons.location_on,
                text: '1.7k',
                iconColor: AppColors.iconColor2),
            IconAndText(
                icon: Icons.watch_later_outlined,
                text: '32min',
                iconColor: Colors.redAccent),
          ],
        )
      ],
    );
  }
}
