import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final IconData? icon;
  final double? width;
  final TextEditingController? controller;
  final GestureTapCallback? press;
  final Widget? dropDown;
  FormFieldValidator<String>? validate;
   CustomFormField({
    required this.title,
    required this.hintText,
    this.controller,
    this.dropDown,
    this.press,
    this.icon,
    this.width,
    this.validate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.only(left: 14.0),
              margin: EdgeInsets.only(top: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: validate,
                      controller: controller,
                      autocorrect: false,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 0,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    icon,
                    size: 35,
                    color: Colors.grey[400],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: dropDown,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
