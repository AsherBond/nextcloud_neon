import 'package:flutter/material.dart';
import 'package:notes_app/l10n/localizations.dart';
import 'package:notes_app/src/blocs/notes.dart';
import 'package:notes_app/src/sort/categories.dart';
import 'package:notes_app/src/widgets/notes_floating_action_button.dart';
import 'package:notes_app/src/widgets/notes_view.dart';

class NotesCategoryPage extends StatelessWidget {
  const NotesCategoryPage({
    required this.bloc,
    required this.category,
    super.key,
  });

  final NotesBloc bloc;
  final NoteCategory category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(category.name.isNotEmpty ? category.name : NotesLocalizations.of(context).categoryUncategorized),
      ),
      body: SafeArea(
        child: NotesView(
          bloc: bloc,
          category: category.name,
        ),
      ),
      floatingActionButton: NotesFloatingActionButton(
        bloc: bloc,
        category: category.name,
      ),
    );
  }
}
