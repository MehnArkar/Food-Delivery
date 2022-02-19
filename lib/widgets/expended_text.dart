import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/small_text.dart';

class ExpendedText extends StatefulWidget {
  final String text;

  const ExpendedText({Key? key, required this.text}) : super(key: key);

  @override
  _ExpendedTextState createState() => _ExpendedTextState();
}

class _ExpendedTextState extends State<ExpendedText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = Dimension.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf == ""
            ? SmallText(
                heigh: 1.8,
                text: firstHalf,
                size: Dimension.fontsize16,
                color: AppColors.paraColor,
              )
            : Column(
                children: [
                  SmallText(
                    text: hiddenText
                        ? (firstHalf + "...")
                        : (firstHalf + secondHalf),
                    size: Dimension.fontsize16,
                    color: AppColors.paraColor,
                    heigh: 1.8,
                  ),
                  hiddenText
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              hiddenText = !hiddenText;
                            });
                          },
                          child: Row(children: [
                            SmallText(
                              text: 'Show more',
                              color: AppColors.mainColor,
                            ),
                            Icon(Icons.arrow_drop_down,
                                color: AppColors.mainColor)
                          ]),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              hiddenText = !hiddenText;
                            });
                          },
                          child: Row(children: [
                            SmallText(
                                text: 'Show less', color: AppColors.mainColor),
                            Icon(Icons.arrow_drop_up,
                                color: AppColors.mainColor)
                          ]),
                        ),
                ],
              ));
  }
}
