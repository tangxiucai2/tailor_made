import 'package:flutter/material.dart';
import 'package:tailor_made/redux/actions/contacts.dart';
import 'package:tailor_made/redux/view_models/contacts.dart';
import 'package:tailor_made/utils/tm_theme.dart';

class ContactsFilterButton extends StatelessWidget {
  final ContactsViewModel vm;

  const ContactsFilterButton({
    Key key,
    @required this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TMTheme theme = TMTheme.of(context);
    return new SizedBox.fromSize(
      size: Size.square(48.0),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: new PopupMenuButton<SortType>(
              icon: new Icon(
                Icons.filter_list,
                color: theme.appBarColor,
              ),
              onSelected: onTapSort(vm),
              itemBuilder: (BuildContext context) => [
                    buildTextOption(
                      "Sort by Jobs",
                      SortType.jobs,
                    ),
                    buildTextOption(
                      "Sort by Name",
                      SortType.name,
                    ),
                    buildTextOption(
                      "Sort by Pending",
                      SortType.pending,
                    ),
                    buildTextOption(
                      "Sort by Recent",
                      SortType.recent,
                    ),
                    buildTextOption(
                      "No Sort",
                      SortType.reset,
                    ),
                  ],
            ),
          ),
          new Align(
            alignment: Alignment(0.75, -0.5),
            child: vm.hasSortFn
                ? new Container(
                    width: 15.5,
                    height: 15.5,
                    decoration: new BoxDecoration(
                      color: kAccentColor,
                      border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 2.5,
                      ),
                      shape: BoxShape.circle,
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }

  Widget buildTextOption(String text, SortType type) {
    return new PopupMenuItem<SortType>(
      value: type,
      enabled: vm.sortFn != type,
      child: new Text(
        text,
        style: ralewayRegular(
          14.0,
          vm.sortFn == type ? kAccentColor : Colors.black87,
        ),
      ),
    );
  }

  Function(SortType) onTapSort(ContactsViewModel vm) =>
      (SortType type) => vm.setSortFn(type);
}
