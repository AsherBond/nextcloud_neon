import 'package:flutter/material.dart';
import 'package:neon_framework/theme.dart';
import 'package:notes_app/l10n/localizations.dart';
import 'package:notes_app/src/utils/category_color.dart';

class NotesCategorySelect extends StatelessWidget {
  NotesCategorySelect({
    required this.categories,
    required this.onChanged,
    required this.onSubmitted,
    this.initialValue,
    super.key,
  }) {
    if (initialValue != null) {
      onChanged(initialValue!);
    }

    categories.sort();

    if (categories.isEmpty) {
      categories.insert(0, '');
    }
  }

  final List<String> categories;
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      initialValue: initialValue != null
          ? TextEditingValue(
              text: initialValue!,
            )
          : null,
      optionsBuilder: (value) {
        if (value.text.isEmpty) {
          return categories;
        }
        return categories.where((category) => category.toLowerCase().contains(value.text.toLowerCase()));
      },
      fieldViewBuilder: (
        context,
        textEditingController,
        focusNode,
        onFieldSubmitted,
      ) =>
          TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: NotesLocalizations.of(context).category,
        ),
        onFieldSubmitted: (value) {
          onChanged(value);
          onSubmitted();
          onFieldSubmitted();
        },
        onChanged: onChanged,
      ),
      optionsViewBuilder: (context, onSelected, options) => Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options.elementAt(index);
                return ListTile(
                  leading: Icon(
                    AdaptiveIcons.tag,
                    color: option.isNotEmpty ? NotesCategoryColor.compute(option) : null,
                  ),
                  title: Text(
                    option.isNotEmpty ? option : NotesLocalizations.of(context).categoryUncategorized,
                  ),
                  onTap: () {
                    onSelected(option);
                  },
                );
              },
            ),
          ),
        ),
      ),
      onSelected: (value) {
        if (categories.contains(value)) {
          onChanged(value);
        }
      },
    );
  }
}
