// lib/common/widgets/custom_app_bar.dart
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? elevation;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = true, // Default to center title
    this.leading,
    this.backgroundColor,
    this.titleColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.white, // Default to white or theme color
        ),
      ),
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
      backgroundColor: backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor ?? Theme.of(context).primaryColor, // Default to primary color
      elevation: elevation ?? Theme.of(context).appBarTheme.elevation ?? 4.0,
      iconTheme: Theme.of(context).appBarTheme.iconTheme, // Inherit icon theme
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}