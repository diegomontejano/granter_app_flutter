import "package:flutter/material.dart";

class CustomButton extends StatelessWidget {
  // attributes
  final Widget child;
  final VoidCallback onTap;
  final Color? hoverColor;
  final Color? highlightColor;

  // constructor
  const CustomButton({
    required this.child,
    required this.onTap,
    this.hoverColor,
    this.highlightColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: child, // child attribute
        onTap: onTap, // onTap attribute
        borderRadius: BorderRadius.circular(100),
        hoverColor: hoverColor, // hoverColor attribute
        highlightColor: highlightColor, // highlightColor attribute
      ),
    );
  }
}
