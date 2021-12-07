import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:oasis_bible_app/widgets/rant_wall/rant_wall.dart';

class HomeHeader extends StatefulWidget
{
  const HomeHeader({ Key? key }) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader>
{
  int _currentPage = 0;

  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      height: 85,
      decoration: const BoxDecoration
      (
        image: DecorationImage
        (
          image: AssetImage("assets/images/banner.jpeg"),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter
        )
      ),
      child: Row
      (
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          const Text
          (
            "Come and Behold",
            style: TextStyle
            (
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Padding
          (
            padding: const EdgeInsets.only(left: 15),
            child: Row
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                _navButton("Resources", index: 0),
                _navButton("Prayer Hotline", index: 1),
                _navButton
                (
                  "Rant Wall", index: 2,
                  onPressed: ()
                  {
                    showAlignedDialog
                    (
                      context: context,
                      followerAnchor: Alignment.topRight,
                      builder: (context) => const RantWall(),
                      isGlobal: true,
                      transitionsBuilder: (context, animation, secondaryAnimation, child)
                      {
                        return SlideTransition
                        (
                          position:
                            Tween(begin: const Offset(1, 0), end: const Offset(0, 0))
                              .animate(animation),
                          child: child,
                        );
                      }
                    ).then((value) => setState(() => _currentPage = 0));
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navButton(String text, {required int index, void Function()? onPressed})
  {
    return TextButton
    (
      child: Text
      (
        text,
        style: TextStyle
        (
          fontSize: 15,
          color: (index == _currentPage)
            ? const Color(0xFF36C9C9)
            : Colors.black45,
          fontWeight: FontWeight.w300
        ),
      ),
      onPressed: ()
      {
        setState(() => _currentPage = index);
        if (onPressed != null) onPressed();
      },
    );
  }
}