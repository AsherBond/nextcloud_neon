import 'package:flutter/material.dart';
import 'package:neon_framework/theme.dart';
import 'package:news_app/l10n/localizations.dart';
import 'package:news_app/src/blocs/news.dart';
import 'package:news_app/src/utils/dialog.dart';

class NewsFolderFloatingActionButton extends StatelessWidget {
  const NewsFolderFloatingActionButton({
    required this.bloc,
    super.key,
  });

  final NewsBloc bloc;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final result = await showFolderCreateDialog(context: context);

        if (result != null) {
          bloc.createFolder(result);
        }
      },
      tooltip: NewsLocalizations.of(context).folderCreate,
      child: Icon(AdaptiveIcons.add),
    );
  }
}
