// coverage:ignore-file
import 'package:nextcloud/src/api/webdav/webdav_client.dart';
import 'package:nextcloud/src/nextcloud_client.dart';

export 'src/api/webdav/webdav.dart' hide DurationXMLConverter, WebDavCSRFClient, constructUri, parseWebDavOptions;

// ignore: public_member_api_docs
extension WebDAVExtension on NextcloudClient {
  static final _webdav = Expando<WebDavClient>();

  /// Client for WebDAV
  WebDavClient get webdav => _webdav[this] ??= WebDavClient(this);
}
