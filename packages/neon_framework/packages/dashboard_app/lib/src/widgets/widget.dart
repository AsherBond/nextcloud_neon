import 'package:dashboard_app/l10n/localizations.dart';
import 'package:flutter/material.dart';
import 'package:neon_framework/models.dart';
import 'package:neon_framework/utils.dart';
import 'package:nextcloud/dashboard.dart' as dashboard;

/// Displays a single dashboard widget and its items.
class DashboardWidget extends StatelessWidget {
  /// Creates a new dashboard widget items.
  const DashboardWidget({
    required this.widget,
    required this.children,
    super.key,
  });

  /// The dashboard widget to be displayed.
  final dashboard.Widget widget;

  /// The items of the widget to be displayed.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    Widget child = Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: children,
      ),
    );

    if (widget.widgetUrl != null && widget.widgetUrl!.isNotEmpty) {
      child = Tooltip(
        message: DashboardLocalizations.of(context).openWidget,
        child: InkWell(
          onTap: () async => launchUrl(NeonProvider.of<Account>(context), widget.widgetUrl!),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: child,
        ),
      );
    }

    return Card(
      child: child,
    );
  }
}
