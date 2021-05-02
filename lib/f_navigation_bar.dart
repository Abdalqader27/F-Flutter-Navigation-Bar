library f_navigation_bar;

import 'package:flutter/material.dart';

import 'f_navigation_bar_item.dart';
import 'f_navigation_bar_theme.dart';

export 'f_navigation_bar_item.dart';
export 'f_navigation_bar_theme.dart';

class FNavigationBar extends StatefulWidget {
  final Function onSelectTab;
  final List<FNavigationBarItem> items;
  final FNavigationBarTheme theme;

  final int selectedIndex;

  FNavigationBar({
    Key key,
    this.selectedIndex = 0,
    @required this.onSelectTab,
    @required this.items,
    @required this.theme,
  }) {
    assert(items != null);
    assert(items.length >= 2 && items.length <= 5);
    assert(onSelectTab != null);
  }

  @override
  _FNavigationBarState createState() => _FNavigationBarState(selectedIndex: selectedIndex);
}

class _FNavigationBarState extends State<FNavigationBar> {
  int selectedIndex;

  _FNavigationBarState({this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final FNavigationBarTheme theme = widget.theme;
    final bgColor = theme.barBackgroundColor ?? Theme.of(context).bottomAppBarColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: theme.barHeight,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.items.map((item) {
              var index = widget.items.indexOf(item);
              item.setIndex(index);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.onSelectTab(index);
                    selectedIndex = index;
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / widget.items.length,
                    height: theme.barHeight,
                    child: item,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
