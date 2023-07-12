import 'package:flutter/material.dart';
import 'package:berana/shared/base_colors.dart';
import 'package:berana/shared/base_fonts.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);

  final String? pageTitle;
  final String? description;

  final bool hasBackButton;

  final Widget? trailing;
  final Color? backgroundColor;
  final Color? barThemeColor;
  final Widget? backgroundWidget;
  final double? elevation;
  final PreferredSizeWidget? bottomWidget;
  final bool centered;

  BaseAppBar({
    this.pageTitle,
    this.centered = false,
    this.description,
    this.hasBackButton = false,
    this.trailing,
    this.backgroundColor,
    this.barThemeColor,
    this.backgroundWidget,
    this.elevation,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: bottomWidget,
      flexibleSpace: backgroundWidget,
      iconTheme: IconThemeData(color: barThemeColor ?? BaseColors.black),
      actionsIconTheme: IconThemeData(color: BaseColors.mainColor),
      elevation: elevation ?? 0.65,
      leading: () {
        if(hasBackButton) {
          return IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        } else {
          return SizedBox();
        }
      } (),
      title: Column(
        children: [
          pageTitle != null
              ? Text(
                  pageTitle!,
                  style: TextStyle(color: barThemeColor ?? BaseColors.black),
                )
              : SizedBox(),
          description != null
              ? Text(
                  description!,
                  style: BaseFonts.footNote(color: BaseColors.grey2),
                )
              : SizedBox(),
        ],
      ),
      centerTitle: true,
      backgroundColor: backgroundColor ?? BaseColors.white,
      actions: [trailing != null ? trailing! : SizedBox()],
    );
  }
}
