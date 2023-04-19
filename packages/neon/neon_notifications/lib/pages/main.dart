part of '../neon_notifications.dart';

class NotificationsMainPage extends StatefulWidget {
  const NotificationsMainPage({
    required this.bloc,
    super.key,
  });

  final NotificationsBloc bloc;

  @override
  State<NotificationsMainPage> createState() => _NotificationsMainPageState();
}

class _NotificationsMainPageState extends State<NotificationsMainPage> {
  @override
  void initState() {
    super.initState();

    widget.bloc.errors.listen((final error) {
      NeonException.showSnackbar(context, error);
    });
  }

  @override
  Widget build(final BuildContext context) =>
      ResultBuilder<NotificationsBloc, List<NextcloudNotificationsNotification>>(
        stream: widget.bloc.notifications,
        builder: (final context, final notifications) => Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              widget.bloc.deleteAllNotifications();
            },
            child: const Icon(MdiIcons.checkAll),
          ),
          body: NeonListView<NextcloudNotificationsNotification>(
            scrollKey: 'notifications-notifications',
            withFloatingActionButton: true,
            items: notifications.data,
            isLoading: notifications.loading,
            error: notifications.error,
            onRefresh: widget.bloc.refresh,
            builder: _buildNotification,
          ),
        ),
      );

  Widget _buildNotification(
    final BuildContext context,
    final NextcloudNotificationsNotification notification,
  ) {
    final app = Provider.of<List<AppImplementation>>(context, listen: false).find(notification.app);

    return ListTile(
      title: Text(notification.subject),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (notification.message.isNotEmpty) ...[
            Text(
              notification.message,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 5,
            ),
          ],
          RelativeTime(
            date: DateTime.parse(notification.datetime),
          ),
        ],
      ),
      leading: app != null
          ? app.buildIcon(
              context,
              width: 40,
              height: 40,
            )
          : SizedBox(
              width: 40,
              height: 40,
              child: NeonCachedUrlImage(
                url: notification.icon,
                width: 40,
                height: 40,
                svgColor: Theme.of(context).colorScheme.primary,
              ),
            ),
      onTap: () async {
        if (notification.app == 'notifications') {
          return;
        }
        if (app != null) {
          final accountsBloc = Provider.of<AccountsBloc>(context, listen: false);
          await accountsBloc.getAppsBloc(accountsBloc.activeAccount.value!).setActiveApp(app.id);
        } else {
          await showDialog(
            context: context,
            builder: (final context) => AlertDialog(
              title: Text(AppLocalizations.of(context).notificationsNextcloudAppNotImplementedYet),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context).close),
                ),
              ],
            ),
          );
        }
      },
      onLongPress: () {
        widget.bloc.deleteNotification(notification.notificationId);
      },
    );
  }
}