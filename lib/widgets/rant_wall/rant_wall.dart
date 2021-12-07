import 'package:flutter/material.dart';
import 'package:oasis_bible_app/util/util.dart';
import 'package:oasis_bible_app/widgets/rant_wall/rant_wall_item.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class _Rant
{
  final String name, rant;
  _Rant({required this.name, required this.rant});
}

class RantWall extends StatefulWidget
{
  const RantWall({ Key? key }) : super(key: key);

  @override
  _RantWallState createState() => _RantWallState();
}

class _RantWallState extends State<RantWall> with SingleTickerProviderStateMixin
{
  final List<_Rant> _rants = [];
  bool _loadingRants = true;
  final TextEditingController _nameField = TextEditingController();
  final TextEditingController _rantField = TextEditingController();

  @override
  void initState()
  {
    _getRants();

    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return Material
    (
      child: Container
      (
        decoration: BoxDecoration
        (
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
        ),
        padding: const EdgeInsets.all(10),
        child: ConstrainedBox
        (
          constraints: const BoxConstraints(maxWidth: 300),
          child: Column
          (
            children:
            [
              const Text
              (
                "Rant Wall",
                style: TextStyle
                (
                  fontSize: 27,
                  fontWeight: FontWeight.w300
                )
              ),
              Flexible
              (
                child: ListView.builder
                (
                  itemCount: (_rants.isNotEmpty) ? _rants.length : 1,
                  itemBuilder: (context, i)
                  {
                    if (_rants.isNotEmpty)
                      return RantItem(name: _rants[i].name, rant: _rants[i].rant);
                    else
                      return Center
                      (
                        child: Padding
                        (
                          padding: const EdgeInsets.all(15),
                          child: (_loadingRants)
                            ? const CircularProgressIndicator()
                            : const Text("Nothing here", style: TextStyle(fontSize: 18)),
                        )
                      );
                  }
                )
              ),
              Align
              (
                alignment: Alignment.bottomCenter,
                child: Column
                (
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:
                  [
                    TextField
                    (
                      controller: _nameField,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: const InputDecoration
                      (
                        hintText: "Name",
                        contentPadding: EdgeInsets.all(2)
                      ),
                    ),
                    Padding
                    (
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextField
                      (
                        controller: _rantField,
                        cursorColor: Theme.of(context).primaryColor,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration
                        (
                          hintText: "Rant",
                          contentPadding: EdgeInsets.all(2)
                        ),
                      ),
                    ),
                    IconButton
                    (
                      icon: const Icon(Icons.send, color: Color(0xFF33BBA2)),
                      onPressed: () async
                      {
                        String name = _nameField.text;
                        String rant = _rantField.text;
        
                        if (name.isNotEmpty && rant.isNotEmpty)
                        {
                          if (name.contains(RegExp(r"[a-zA-Z]")) && rant.contains(RegExp(r"[a-zA-Z]")))
                          {
                            _nameField.text = "";
                            _rantField.text = "";
        
                            setState(() =>
                              _rants.add(_Rant(name: name, rant: rant)
                            ));
        
                            final newRant = ParseObject("rant_wall")
                            ..set("name", name)
                            ..set("rant", rant);
                            await newRant.save();
                          }
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getRants() async
  {
    var rants = await Util.getOnlineDB("rant_wall");
    for (var rant in rants)
    {
      _rants.add
      (
        _Rant
        (
          name: rant.get<String>("name") ?? "Name",
          rant: rant.get<String>("rant") ?? "Rant"
        )
      );
    }
    setState(() {});
    _loadingRants = false;
  }
}