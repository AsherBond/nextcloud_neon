import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:meta/meta.dart';
import 'package:nextcloud_test/src/models/models.dart';
import 'package:nextcloud_test/src/test_target/test_target.dart';
import 'package:path/path.dart' as p;
import 'package:process_run/process_run.dart';
import 'package:version/version.dart';

int _randomPort() => 1024 + Random().nextInt(65535 - 1024);

/// Factory for spawning docker containers as test targets.
@internal
final class DockerContainerFactory extends TestTargetFactory<DockerContainerInstance> {
  /// Creates a new docker container and returns its representation.
  @override
  Future<DockerContainerInstance> spawn(Preset preset) async {
    final dockerImageName = 'ghcr.io/nextcloud/neon/dev:${preset.name}-${preset.version.major}.${preset.version.minor}';

    var result = await runExecutableArguments(
      'docker',
      [
        'images',
        '-q',
        dockerImageName,
      ],
    );
    if (result.exitCode != 0) {
      throw Exception('Querying docker image failed: ${result.stderr}');
    }
    if (result.stdout.toString().isEmpty) {
      throw Exception('Missing docker image $dockerImageName. Please build it using ./tool/build-dev-container.sh');
    }

    late int port;
    late String id;

    while (true) {
      port = _randomPort();
      result = await runExecutableArguments(
        'docker',
        [
          'run',
          '--rm',
          '-d',
          '--network',
          'host',
          dockerImageName,
          'php',
          '-S',
          '0.0.0.0:$port',
        ],
      );
      // The command will not fail if the port is already allocated since we run in detached mode.
      if (result.exitCode != 0) {
        throw Exception('Failed to run docker container: ${result.stderr}');
      }

      id = result.stdout.toString().replaceAll('\n', '');

      // Ensure container is still up and didn't crash because the port was already allocated.
      result = await runExecutableArguments(
        'docker',
        [
          'exec',
          '-i',
          id,
          'true',
        ],
      );
      if (result.exitCode == 0) {
        break;
      }
    }

    return DockerContainerInstance(
      id: id,
      port: port,
    );
  }

  @override
  BuiltListMultimap<String, Version> getPresets() {
    final files = Glob('packages/nextcloud_test_presets/docker/presets/**/*').listSync();

    return BuiltListMultimap<String, Version>.build((b) {
      for (final file in files) {
        b.add(
          p.split(file.dirname).last,
          Version.parse(file.basename),
        );
      }
    });
  }
}

/// Test target representing a docker container.
@internal
final class DockerContainerInstance extends TestTargetInstance {
  /// Creates a new Docker container instance.
  DockerContainerInstance({
    required this.id,
    required this.port,
  });

  /// ID of the docker container.
  final String id;

  /// Assigned port of docker container.
  final int port;

  /// Removes the docker container from the system.
  @override
  Future<void> destroy() => runExecutableArguments(
        'docker',
        [
          'kill',
          id,
        ],
      );

  @override
  late Uri url = Uri(
    scheme: 'http',
    host: 'localhost',
    port: port,
  );

  @override
  Future<String> createAppPassword(String username) async {
    final inputStream = StreamController<List<int>>();
    final process = runExecutableArguments(
      'docker',
      [
        'exec',
        '-i',
        id,
        'php',
        '-f',
        'occ',
        'user:add-app-password',
        username,
      ],
      stdin: inputStream.stream,
    );
    inputStream.add(utf8.encode(username));
    await inputStream.close();

    final result = await process;
    if (result.exitCode != 0) {
      throw Exception('Failed to run generate app password command\n${result.stderr}\n${result.stdout}');
    }

    return (result.stdout as String).split('\n')[1];
  }
}
