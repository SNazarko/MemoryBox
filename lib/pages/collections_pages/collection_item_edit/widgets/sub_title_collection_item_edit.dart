import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../collection_item_edit_page_model.dart';

class SubTitleCollectionItemEdit extends StatefulWidget {
  const SubTitleCollectionItemEdit({Key? key, required this.subTitleCollection})
      : super(key: key);
  final String subTitleCollection;
  @override
  _SubTitleCollectionItemEditState createState() =>
      _SubTitleCollectionItemEditState();
}

class _SubTitleCollectionItemEditState
    extends State<SubTitleCollectionItemEdit> {
  final TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    _controller.text = widget.subTitleCollection;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: TextField(
        controller: _controller,
        maxLines: 10,
        minLines: 1,
        onChanged: (subTitleCollectionsEdit) {
          Provider.of<CollectionItemEditPageModel>(context, listen: false)
              .setSubTitleCollectionsEdit(subTitleCollectionsEdit);
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        style: const TextStyle(
          fontSize: 16.0,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
