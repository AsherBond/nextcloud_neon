// ignore_for_file: use_late_for_private_fields_and_variables
// ^ This is a really strange false positive, it goes of at a very random place without any meaning. Hopefully fixed soon?

part of '../../neon.dart';

const kAvatarSize = 40.0;

class NeonUserAvatar extends StatefulWidget {
  NeonUserAvatar({
    required this.account,
    final String? username,
    this.showStatus = true,
    this.size = kAvatarSize,
    super.key,
  }) : username = username ?? account.client.username!;

  final Account account;
  final String username;
  final bool showStatus;
  final double size;

  @override
  State<NeonUserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<NeonUserAvatar> {
  late final _userStatusBloc = Provider.of<AccountsBloc>(context, listen: false).getUserStatusesBloc(widget.account);

  @override
  void initState() {
    super.initState();

    unawaited(_userStatusBloc.load(widget.username));
  }

  @override
  Widget build(final BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = (widget.size * MediaQuery.of(context).devicePixelRatio).toInt();
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: widget.size / 2,
          child: ClipOval(
            child: NeonCachedApiImage(
              account: widget.account,
              cacheKey: 'avatar-${widget.username}-${isDark ? 'dark' : 'light'}$size',
              download: () async {
                if (isDark) {
                  return widget.account.client.core.getDarkAvatar(
                    userId: widget.username,
                    size: size,
                  );
                } else {
                  return widget.account.client.core.getAvatar(
                    userId: widget.username,
                    size: size,
                  );
                }
              },
            ),
          ),
        ),
        if (widget.showStatus) ...[
          ResultBuilder<NextcloudUserStatusPublicStatus?>(
            stream: _userStatusBloc.statuses.map((final statuses) => statuses[widget.username]),
            builder: _userStatusIconBuilder,
          ),
        ],
      ],
    );
  }

  Widget _userStatusIconBuilder(final BuildContext context, final Result<NextcloudUserStatusPublicStatus?> result) {
    final hasEmoji = result.data?.icon != null;
    final scaledSize = widget.size / (hasEmoji ? 2 : 3);

    Widget? child;
    Decoration? decoration;
    if (result.loading) {
      child = CircularProgressIndicator(
        strokeWidth: 1.5,
        color: Theme.of(context).colorScheme.onPrimary,
      );
    } else if (result.error != null) {
      child = Icon(
        Icons.error_outline,
        size: scaledSize,
        color: Theme.of(context).colorScheme.error,
      );
    } else if (hasEmoji) {
      child = Text(
        result.data!.icon!,
        style: const TextStyle(
          fontSize: 16,
        ),
      );
    } else if (result.data != null) {
      decoration = BoxDecoration(
        shape: BoxShape.circle,
        color: _userStatusToColor(result.data!.status),
      );
    }

    return SizedBox.square(
      dimension: widget.size,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          width: scaledSize,
          height: scaledSize,
          decoration: decoration,
          child: child,
        ),
      ),
    );
  }

  Color? _userStatusToColor(final NextcloudUserStatusType userStatusType) => switch (userStatusType) {
        NextcloudUserStatusType.online => const Color(0xFF49B382),
        NextcloudUserStatusType.away => const Color(0xFFF4A331),
        NextcloudUserStatusType.dnd => const Color(0xFFED484C),
        _ => null,
      };
}