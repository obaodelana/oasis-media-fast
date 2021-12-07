import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RantItem extends StatelessWidget
{
  final String name, rant;
  const RantItem({ Key? key, required this.name, required this.rant }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      decoration: BoxDecoration
      (
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15)
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text
          (
            rant,
            style: const TextStyle
            (
              fontWeight: FontWeight.w300,
              color: Colors.black87,
              fontSize: 19
            ),
          ),
          Align
          (
            alignment: Alignment.bottomRight,
            child: RichText
            (
              text: TextSpan
              (
                children:
                [
                  const WidgetSpan
                  (
                    alignment: PlaceholderAlignment.middle,
                    child: Icon
                    (
                      FontAwesomeIcons.user,
                      size: 15,
                      color: Colors.black87
                    )
                  ),
                  TextSpan
                  (
                    text: name,
                    style: const TextStyle(color: Colors.black87, fontSize: 15),
                  )
                ]
              ),
            ),
          )
        ],
      ),
    );
  }
}