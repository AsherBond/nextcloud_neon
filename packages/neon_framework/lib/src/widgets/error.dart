import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neon_framework/l10n/localizations.dart';
import 'package:neon_framework/models.dart';
import 'package:neon_framework/src/router.dart';
import 'package:neon_framework/src/theme/icons.dart';
import 'package:neon_framework/src/utils/exceptions.dart';
import 'package:neon_framework/src/utils/provider.dart';
import 'package:neon_framework/src/widgets/adaptive_widgets/list_tile.dart';

/// The display mode of the [NeonError] widget.
enum NeonErrorType {
  /// Only shows the error icon.
  ///
  /// This mode creates an IconButton that is usually used in size constrained
  /// areas.
  iconOnly,

  /// Shows a column with the error message and a retry button.
  column,

  /// Shows a [AdaptiveListTile] with the error.
  listTile,
}

/// An indicator that an [error] has occurred.
///
/// The action that lead to the error can be retried.
/// The error can be indicated in various styles by providing [type] which
/// defaults to `NeonErrorType.column`.
class NeonError extends StatelessWidget {
  /// Creates a NeonError.
  const NeonError(
    this.error, {
    required this.onRetry,
    this.type = NeonErrorType.column,
    this.iconSize,
    this.color,
    super.key,
  });

  /// The error object.
  ///
  /// Can be of type [String] or [Exception], various subtypes of `Exception` are also handled separately.
  final Object? error;

  /// A function that's called when the user decides to retry the action that lead to the error.
  final VoidCallback? onRetry;

  /// The size of the icon in logical pixels.
  ///
  /// Defaults to a size of `30`.
  final double? iconSize;

  /// The color to use when drawing the error indicator.
  ///
  /// Defaults to the nearest [IconTheme]'s [ColorScheme.error].
  final Color? color;

  /// The display mode of this widget.
  ///
  /// Defaults to `NeonErrorType.column`.
  final NeonErrorType type;

  /// Shows a [SnackBar] popup for the [error].
  static void showSnackbar(BuildContext context, Object? error) {
    final details = NeonExceptionDetails.fromError(error);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(details.getText(context)),
        action: details.isUnauthorized
            ? SnackBarAction(
                label: NeonLocalizations.of(context).loginAgain,
                onPressed: () async => _openLoginPage(context),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (error == null) {
      return const SizedBox();
    }

    final details = NeonExceptionDetails.fromError(error);
    final color = this.color ?? Theme.of(context).colorScheme.error;
    final textStyle = TextStyle(
      color: color,
    );

    final message = details.getText(context);
    final errorIcon = Icon(
      AdaptiveIcons.error_outline,
      size: iconSize ?? 30,
      color: color,
    );

    final actionMessage =
        details.isUnauthorized ? NeonLocalizations.of(context).loginAgain : NeonLocalizations.of(context).actionRetry;

    final onPressed = details.isUnauthorized ? () async => _openLoginPage(context) : onRetry;

    switch (type) {
      case NeonErrorType.iconOnly:
        return Semantics(
          tooltip: details.getText(context),
          child: IconButton(
            icon: errorIcon,
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            tooltip: actionMessage,
            onPressed: onPressed,
          ),
        );
      case NeonErrorType.column:
        return Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  errorIcon,
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(message, style: textStyle),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: onPressed,
                child: Text(actionMessage),
              ),
            ],
          ),
        );
      case NeonErrorType.listTile:
        return AdaptiveListTile(
          leading: errorIcon,
          title: Text(message, style: textStyle),
          onTap: onPressed,
        );
    }
  }

  static Future<void> _openLoginPage(BuildContext context) async {
    await LoginRoute(
      serverUrl: NeonProvider.of<Account>(context).serverURL,
    ).push<void>(context);
  }
}
