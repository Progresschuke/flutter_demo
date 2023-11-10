import 'package:flutter/material.dart';

class SearchAndFilter extends StatelessWidget {
  const SearchAndFilter({
    super.key,
    required this.onPop,
    required this.onSearchFood,
    required this.onUpdateList,
    required this.titleController,
    required this.onTapFilters,
  });

  final Future<bool> Function() onPop;
  final void Function() onSearchFood;
  final void Function(String value) onUpdateList;
  final TextEditingController titleController;
  final void Function() onTapFilters;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //For SearchScreen
          WillPopScope(
            onWillPop: onPop,
            child: Expanded(
              child: TextField(
                controller: titleController,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.background,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onBackground)),
                  hintText: 'Search For Food',
                  prefixIcon: const Icon(Icons.search),
                ),
                onTap: onSearchFood,
                onChanged: onUpdateList,
              ),
            ),
          ),
          SizedBox(width: 5 * size.width / 100),

//For filterScreen
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Theme.of(context).colorScheme.onBackground)),
            width: 15 * size.width / 100,
            height: 15 * size.width / 100,
            child: IconButton(
              icon: const Icon(
                Icons.filter_list,
                size: 35,
              ),
              onPressed: onTapFilters,
            ),
          )
        ],
      ),
    );
  }
}
