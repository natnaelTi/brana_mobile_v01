import 'package:berana/shared/base_colors.dart';
import 'package:berana/widgets/berana_button.dart';
import 'package:flutter/material.dart';

class BeranaDropDown extends StatefulWidget {
  BeranaDropDown({
    Key? key,
    required this.child,
    required this.dropDownItems,
    required this.onChanged
  }) : super(key: key);

  final Widget child;
  final List<Widget> dropDownItems;
  final Function onChanged;

  @override
  State<BeranaDropDown> createState() => _BeranaDropDownState();
}

class _BeranaDropDownState extends State<BeranaDropDown> {
  bool dropDownOpen = false;
  void toggleDropDown() {
    setState(() {
      dropDownOpen = !dropDownOpen;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BeranaButton(
          pressedFunc: () {
            toggleDropDown();
            widget.onChanged();
          },
          foregroundColor: BaseColors.primaryBerana,
          backgroundColor: Colors.white,
          child: widget.child
        ),
        Visibility(
            maintainState: true,
            maintainSize: true,
            maintainAnimation: true,
            visible: dropDownOpen,
            child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ListView.builder(
                    itemCount: widget.dropDownItems.length,
                    itemBuilder: (context, index) {
                      return widget.dropDownItems[index];
                    }
                )
            ),
        )
      ],
    );
  }
}
