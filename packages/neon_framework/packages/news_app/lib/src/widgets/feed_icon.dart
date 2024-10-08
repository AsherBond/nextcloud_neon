import 'package:flutter/material.dart';
import 'package:neon_framework/models.dart';
import 'package:neon_framework/theme.dart';
import 'package:neon_framework/utils.dart';
import 'package:neon_framework/widgets.dart';
import 'package:nextcloud/news.dart' as news;

class NewsFeedIcon extends StatelessWidget {
  const NewsFeedIcon({
    required this.feed,
    this.size = largeIconSize,
    super.key,
  });

  final news.Feed feed;
  final double size;

  @override
  Widget build(BuildContext context) {
    final faviconLink = feed.faviconLink;

    return SizedBox.square(
      dimension: size,
      child: faviconLink != null && faviconLink.isNotEmpty
          ? NeonUriImage(
              uri: Uri.parse(faviconLink),
              size: Size.square(size),
              account: NeonProvider.of<Account>(context),
            )
          : Icon(
              Icons.rss_feed,
              size: size,
              color: Theme.of(context).colorScheme.primary,
            ),
    );
  }
}
