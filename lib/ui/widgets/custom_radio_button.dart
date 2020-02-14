import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  final List<RadioModel> _list;

  //final DataModel selectedCount;
  final ValueNotifier<int> selectedDayNotifier;

  CustomRadio(this._list, this.selectedDayNotifier);

  @override
  createState() {
    return new CustomRadioState();
  }

  factory CustomRadio.create(
      List<RadioModel> list, ValueNotifier<int> selectedDayNotifier) {
    return new CustomRadio(list, selectedDayNotifier);
  }
}

class CustomRadioState extends State<CustomRadio> {
  @override
  void initState() {
    super.initState();
    int index = widget._list
        .indexWhere((r) => r.data == widget.selectedDayNotifier.value);
    if (index >= 0) {
      setState(() {
        widget._list.forEach((element) => element.isSelected = false);
        widget._list[index].isSelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget._list.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: new EdgeInsets.all(4.0),
          child: new InkWell(
            splashColor: Theme.of(context).accentColor,
            onTap: () {
              setState(() {
                widget._list.forEach((element) => element.isSelected = false);
                widget._list[index].isSelected = true;
                widget.selectedDayNotifier.value = widget._list[index].data;
              });
            },
            child: new RadioItem(widget._list[index]),
          ),
        );
      },
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 32.0,
            width: 72.0,
            child: new Center(
              child: new Text(_item.text,
                  style: new TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 12.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? Theme.of(context).accentColor
                  : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? Theme.of(context).accentColor
                      : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
        ],
      ),
    );
  }
}

class RadioModel {
  int data;
  bool isSelected;
  final String text;

  RadioModel(this.isSelected, this.data, this.text);
}
