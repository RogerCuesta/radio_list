import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radio/features/home/home.dart';

class RadioSearchBar extends StatelessWidget {
  const RadioSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 55.0,
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).cardColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              offset: Offset(1.5, 1.5),
            )
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 10.0),
            Icon(
              CupertinoIcons.search,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Buscar',
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).textTheme.bodySmall!.color,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onSubmitted: (String searchTerm) => context
                    .read<HomeCubit>()
                    .loadRadioChannels(
                        searchText: searchTerm, resetPagination: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
