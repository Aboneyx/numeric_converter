import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Widget body;
  final Function onClick;
  final ButtonStyle style;
  final double? width;
  final double? height;

  const CustomButton({
    Key? key,
    required this.body,
    required this.onClick,
    required this.style,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width,
      height: widget.height == 0 ? null : widget.height,
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: ElevatedButton(
        onPressed: () {
          widget.onClick();
        },
        style: widget.style,
        child: widget.body,
      ),
    );
  }
}

ButtonStyle whiteButtonStyle() {
  return ElevatedButton.styleFrom(
    onPrimary: Colors.black,
    primary: Colors.white,
    shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    // shadowColor: MaterialStateProperty.all<Color>(
    //   Colors.black,
    //   // const Color.fromRGBO(255, 255, 255, 0),
    // ),
    // backgroundColor: MaterialStateProperty.all<Color>(
    //   const Color.fromRGBO(255, 255, 255, 1),
    // ),
    // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //   RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(7),
    //   ),
    // ),
  );
}

ButtonStyle blackButtonStyle() {
  return ButtonStyle(
    shadowColor: MaterialStateProperty.all<Color>(
      const Color.fromRGBO(255, 255, 255, 1),
    ),
    backgroundColor:
        MaterialStateProperty.all<Color>(const Color.fromRGBO(0, 0, 0, 1.0)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.white),
      ),
    ),
  );
}

ButtonStyle purpleButtonStyle() {
  return ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.purple,
    shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
