import 'package:flutter/material.dart';
import 'package:oasis_bible_app/widgets/feed/feed.dart';
import 'package:oasis_bible_app/widgets/header.dart';
import 'package:oasis_bible_app/widgets/verse_of_the_day.dart';

class HomePage extends StatefulWidget
{
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  @override
  Widget build(BuildContext context)
  {
    return _getWidgets();
  }

  Widget _getWidgets()
  {
    if (MediaQuery.of(context).size.width > 900)
    {
      return Column
      (
        children:
        [
          const HomeHeader(),
          Expanded
          (
            child: Row
            (
              children: const
              [
                Flexible(child: VerseOfTheDay()),
                Flexible(child: Feed())
              ],
            )
          )
        ],
      );
    }
    else
    {
      return SingleChildScrollView
      (
        child: Column
        (
          children: const
          [
            HomeHeader(),
            SizedBox(height: 400, width: double.infinity, child: VerseOfTheDay()),
            SizedBox(child: Feed(smallScreen: false), height: 800,),
          ],
        )
      );
    }
  }

}