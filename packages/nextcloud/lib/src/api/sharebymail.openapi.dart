// Use of this source code is governed by a agpl license. It can be obtained at `https://spdx.org/licenses/AGPL-3.0-only.html`.

// OpenAPI client generated by Dynamite. Do not manually edit this file.

// ignore_for_file: camel_case_extensions, camel_case_types, discarded_futures
// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: public_member_api_docs, unreachable_switch_case

/// sharebymail Version: 0.0.1.
///
/// Share provider which allows you to share files by mail.
///
/// Use of this source code is governed by a agpl license.
/// It can be obtained at `https://spdx.org/licenses/AGPL-3.0-only.html`.
library; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' as _i4;
import 'package:dynamite_runtime/built_value.dart' as _i3;
import 'package:dynamite_runtime/utils.dart' as _i1;
import 'package:meta/meta.dart' as _i2;

part 'sharebymail.openapi.g.dart';

@BuiltValue(instantiable: false)
abstract interface class $Capabilities0_FilesSharing_Sharebymail_UploadFilesDropInterface {
  bool get enabled;
}

abstract class Capabilities0_FilesSharing_Sharebymail_UploadFilesDrop
    implements
        $Capabilities0_FilesSharing_Sharebymail_UploadFilesDropInterface,
        Built<Capabilities0_FilesSharing_Sharebymail_UploadFilesDrop,
            Capabilities0_FilesSharing_Sharebymail_UploadFilesDropBuilder> {
  /// Creates a new Capabilities0_FilesSharing_Sharebymail_UploadFilesDrop object using the builder pattern.
  factory Capabilities0_FilesSharing_Sharebymail_UploadFilesDrop([
    void Function(Capabilities0_FilesSharing_Sharebymail_UploadFilesDropBuilder)? b,
  ]) = _$Capabilities0_FilesSharing_Sharebymail_UploadFilesDrop;

  // coverage:ignore-start
  const Capabilities0_FilesSharing_Sharebymail_UploadFilesDrop._();
  // coverage:ignore-end

  /// Creates a new object from the given [json] data.
  ///
  /// Use [toJson] to serialize it back into json.
  // coverage:ignore-start
  factory Capabilities0_FilesSharing_Sharebymail_UploadFilesDrop.fromJson(Map<String, dynamic> json) =>
      _$jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  /// Parses this object into a json like map.
  ///
  /// Use the fromJson factory to revive it again.
  // coverage:ignore-start
  Map<String, dynamic> toJson() => _$jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  /// Serializer for Capabilities0_FilesSharing_Sharebymail_UploadFilesDrop.
  static Serializer<Capabilities0_FilesSharing_Sharebymail_UploadFilesDrop> get serializer =>
      _$capabilities0FilesSharingSharebymailUploadFilesDropSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class $Capabilities0_FilesSharing_Sharebymail_PasswordInterface {
  bool get enabled;
  bool get enforced;
}

abstract class Capabilities0_FilesSharing_Sharebymail_Password
    implements
        $Capabilities0_FilesSharing_Sharebymail_PasswordInterface,
        Built<Capabilities0_FilesSharing_Sharebymail_Password, Capabilities0_FilesSharing_Sharebymail_PasswordBuilder> {
  /// Creates a new Capabilities0_FilesSharing_Sharebymail_Password object using the builder pattern.
  factory Capabilities0_FilesSharing_Sharebymail_Password([
    void Function(Capabilities0_FilesSharing_Sharebymail_PasswordBuilder)? b,
  ]) = _$Capabilities0_FilesSharing_Sharebymail_Password;

  // coverage:ignore-start
  const Capabilities0_FilesSharing_Sharebymail_Password._();
  // coverage:ignore-end

  /// Creates a new object from the given [json] data.
  ///
  /// Use [toJson] to serialize it back into json.
  // coverage:ignore-start
  factory Capabilities0_FilesSharing_Sharebymail_Password.fromJson(Map<String, dynamic> json) =>
      _$jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  /// Parses this object into a json like map.
  ///
  /// Use the fromJson factory to revive it again.
  // coverage:ignore-start
  Map<String, dynamic> toJson() => _$jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  /// Serializer for Capabilities0_FilesSharing_Sharebymail_Password.
  static Serializer<Capabilities0_FilesSharing_Sharebymail_Password> get serializer =>
      _$capabilities0FilesSharingSharebymailPasswordSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class $Capabilities0_FilesSharing_Sharebymail_ExpireDateInterface {
  bool get enabled;
  bool get enforced;
}

abstract class Capabilities0_FilesSharing_Sharebymail_ExpireDate
    implements
        $Capabilities0_FilesSharing_Sharebymail_ExpireDateInterface,
        Built<Capabilities0_FilesSharing_Sharebymail_ExpireDate,
            Capabilities0_FilesSharing_Sharebymail_ExpireDateBuilder> {
  /// Creates a new Capabilities0_FilesSharing_Sharebymail_ExpireDate object using the builder pattern.
  factory Capabilities0_FilesSharing_Sharebymail_ExpireDate([
    void Function(Capabilities0_FilesSharing_Sharebymail_ExpireDateBuilder)? b,
  ]) = _$Capabilities0_FilesSharing_Sharebymail_ExpireDate;

  // coverage:ignore-start
  const Capabilities0_FilesSharing_Sharebymail_ExpireDate._();
  // coverage:ignore-end

  /// Creates a new object from the given [json] data.
  ///
  /// Use [toJson] to serialize it back into json.
  // coverage:ignore-start
  factory Capabilities0_FilesSharing_Sharebymail_ExpireDate.fromJson(Map<String, dynamic> json) =>
      _$jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  /// Parses this object into a json like map.
  ///
  /// Use the fromJson factory to revive it again.
  // coverage:ignore-start
  Map<String, dynamic> toJson() => _$jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  /// Serializer for Capabilities0_FilesSharing_Sharebymail_ExpireDate.
  static Serializer<Capabilities0_FilesSharing_Sharebymail_ExpireDate> get serializer =>
      _$capabilities0FilesSharingSharebymailExpireDateSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class $Capabilities0_FilesSharing_SharebymailInterface {
  bool get enabled;
  @BuiltValueField(wireName: 'send_password_by_mail')
  bool get sendPasswordByMail;
  @BuiltValueField(wireName: 'upload_files_drop')
  Capabilities0_FilesSharing_Sharebymail_UploadFilesDrop get uploadFilesDrop;
  Capabilities0_FilesSharing_Sharebymail_Password get password;
  @BuiltValueField(wireName: 'expire_date')
  Capabilities0_FilesSharing_Sharebymail_ExpireDate get expireDate;
}

abstract class Capabilities0_FilesSharing_Sharebymail
    implements
        $Capabilities0_FilesSharing_SharebymailInterface,
        Built<Capabilities0_FilesSharing_Sharebymail, Capabilities0_FilesSharing_SharebymailBuilder> {
  /// Creates a new Capabilities0_FilesSharing_Sharebymail object using the builder pattern.
  factory Capabilities0_FilesSharing_Sharebymail([void Function(Capabilities0_FilesSharing_SharebymailBuilder)? b]) =
      _$Capabilities0_FilesSharing_Sharebymail;

  // coverage:ignore-start
  const Capabilities0_FilesSharing_Sharebymail._();
  // coverage:ignore-end

  /// Creates a new object from the given [json] data.
  ///
  /// Use [toJson] to serialize it back into json.
  // coverage:ignore-start
  factory Capabilities0_FilesSharing_Sharebymail.fromJson(Map<String, dynamic> json) =>
      _$jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  /// Parses this object into a json like map.
  ///
  /// Use the fromJson factory to revive it again.
  // coverage:ignore-start
  Map<String, dynamic> toJson() => _$jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  /// Serializer for Capabilities0_FilesSharing_Sharebymail.
  static Serializer<Capabilities0_FilesSharing_Sharebymail> get serializer =>
      _$capabilities0FilesSharingSharebymailSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class $Capabilities0_FilesSharingInterface {
  Capabilities0_FilesSharing_Sharebymail get sharebymail;
}

abstract class Capabilities0_FilesSharing
    implements
        $Capabilities0_FilesSharingInterface,
        Built<Capabilities0_FilesSharing, Capabilities0_FilesSharingBuilder> {
  /// Creates a new Capabilities0_FilesSharing object using the builder pattern.
  factory Capabilities0_FilesSharing([void Function(Capabilities0_FilesSharingBuilder)? b]) =
      _$Capabilities0_FilesSharing;

  // coverage:ignore-start
  const Capabilities0_FilesSharing._();
  // coverage:ignore-end

  /// Creates a new object from the given [json] data.
  ///
  /// Use [toJson] to serialize it back into json.
  // coverage:ignore-start
  factory Capabilities0_FilesSharing.fromJson(Map<String, dynamic> json) =>
      _$jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  /// Parses this object into a json like map.
  ///
  /// Use the fromJson factory to revive it again.
  // coverage:ignore-start
  Map<String, dynamic> toJson() => _$jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  /// Serializer for Capabilities0_FilesSharing.
  static Serializer<Capabilities0_FilesSharing> get serializer => _$capabilities0FilesSharingSerializer;
}

@BuiltValue(instantiable: false)
abstract interface class $Capabilities0Interface {
  @BuiltValueField(wireName: 'files_sharing')
  Capabilities0_FilesSharing get filesSharing;
}

abstract class Capabilities0 implements $Capabilities0Interface, Built<Capabilities0, Capabilities0Builder> {
  /// Creates a new Capabilities0 object using the builder pattern.
  factory Capabilities0([void Function(Capabilities0Builder)? b]) = _$Capabilities0;

  // coverage:ignore-start
  const Capabilities0._();
  // coverage:ignore-end

  /// Creates a new object from the given [json] data.
  ///
  /// Use [toJson] to serialize it back into json.
  // coverage:ignore-start
  factory Capabilities0.fromJson(Map<String, dynamic> json) => _$jsonSerializers.deserializeWith(serializer, json)!;
  // coverage:ignore-end

  /// Parses this object into a json like map.
  ///
  /// Use the fromJson factory to revive it again.
  // coverage:ignore-start
  Map<String, dynamic> toJson() => _$jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;
  // coverage:ignore-end

  /// Serializer for Capabilities0.
  static Serializer<Capabilities0> get serializer => _$capabilities0Serializer;
}

typedef Capabilities = ({BuiltList<Never>? builtListNever, Capabilities0? capabilities0});

/// Serialization extension for `Capabilities`.
extension $CapabilitiesExtension on Capabilities {
  /// Serializer for Capabilities.
  @BuiltValueSerializer(custom: true)
  static Serializer<Capabilities> get serializer => $7f1b9936cf688676379074249fff891bExtension._serializer;

  /// Creates a new object from the given [json] data.
  ///
  /// Use `toJson` to serialize it back into json.
  static Capabilities fromJson(Object? json) => $7f1b9936cf688676379074249fff891bExtension._fromJson(json);
}

typedef _$7f1b9936cf688676379074249fff891b = ({BuiltList<Never>? builtListNever, Capabilities0? capabilities0});

/// @nodoc
// ignore: library_private_types_in_public_api
extension $7f1b9936cf688676379074249fff891bExtension on _$7f1b9936cf688676379074249fff891b {
  List<dynamic> get _values => [builtListNever, capabilities0];

  /// {@macro Dynamite.validateOneOf}
  void validateOneOf() => _i1.validateOneOf(_values);

  /// {@macro Dynamite.validateAnyOf}
  void validateAnyOf() => _i1.validateAnyOf(_values);
  static Serializer<_$7f1b9936cf688676379074249fff891b> get _serializer =>
      const _$7f1b9936cf688676379074249fff891bSerializer();
  static _$7f1b9936cf688676379074249fff891b _fromJson(Object? json) =>
      _$jsonSerializers.deserializeWith(_serializer, json)!;

  /// Parses this object into a json like map.
  ///
  /// Use the fromJson factory to revive it again.
  Object? toJson() => _$jsonSerializers.serializeWith(_serializer, this);
}

class _$7f1b9936cf688676379074249fff891bSerializer implements PrimitiveSerializer<_$7f1b9936cf688676379074249fff891b> {
  const _$7f1b9936cf688676379074249fff891bSerializer();

  @override
  Iterable<Type> get types => const [_$7f1b9936cf688676379074249fff891b];

  @override
  String get wireName => r'_$7f1b9936cf688676379074249fff891b';

  @override
  Object serialize(
    Serializers serializers,
    _$7f1b9936cf688676379074249fff891b object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    dynamic value;
    value = object.builtListNever;
    if (value != null) {
      return serializers.serialize(value, specifiedType: const FullType(BuiltList, [FullType(Never)]))!;
    }
    value = object.capabilities0;
    if (value != null) {
      return serializers.serialize(value, specifiedType: const FullType(Capabilities0))!;
    }
// Should not be possible after validation.
    throw StateError('Tried to serialize without any value.');
  }

  @override
  _$7f1b9936cf688676379074249fff891b deserialize(
    Serializers serializers,
    Object data, {
    FullType specifiedType = FullType.unspecified,
  }) {
    BuiltList<Never>? builtListNever;
    try {
      builtListNever = serializers.deserialize(data, specifiedType: const FullType(BuiltList, [FullType(Never)]))!
          as BuiltList<Never>;
    } catch (_) {}
    Capabilities0? capabilities0;
    try {
      capabilities0 = serializers.deserialize(data, specifiedType: const FullType(Capabilities0))! as Capabilities0;
    } catch (_) {}
    return (builtListNever: builtListNever, capabilities0: capabilities0);
  }
}

// coverage:ignore-start
/// Serializer for all values in this library.
///
/// Serializes values into the `built_value` wire format.
/// See: [$jsonSerializers] for serializing into json.
@_i2.visibleForTesting
final Serializers $serializers = _$serializers;
final Serializers _$serializers = (Serializers().toBuilder()
      ..addBuilderFactory(const FullType(Capabilities0), Capabilities0Builder.new)
      ..add(Capabilities0.serializer)
      ..addBuilderFactory(const FullType(Capabilities0_FilesSharing), Capabilities0_FilesSharingBuilder.new)
      ..add(Capabilities0_FilesSharing.serializer)
      ..addBuilderFactory(
        const FullType(Capabilities0_FilesSharing_Sharebymail),
        Capabilities0_FilesSharing_SharebymailBuilder.new,
      )
      ..add(Capabilities0_FilesSharing_Sharebymail.serializer)
      ..addBuilderFactory(
        const FullType(Capabilities0_FilesSharing_Sharebymail_UploadFilesDrop),
        Capabilities0_FilesSharing_Sharebymail_UploadFilesDropBuilder.new,
      )
      ..add(Capabilities0_FilesSharing_Sharebymail_UploadFilesDrop.serializer)
      ..addBuilderFactory(
        const FullType(Capabilities0_FilesSharing_Sharebymail_Password),
        Capabilities0_FilesSharing_Sharebymail_PasswordBuilder.new,
      )
      ..add(Capabilities0_FilesSharing_Sharebymail_Password.serializer)
      ..addBuilderFactory(
        const FullType(Capabilities0_FilesSharing_Sharebymail_ExpireDate),
        Capabilities0_FilesSharing_Sharebymail_ExpireDateBuilder.new,
      )
      ..add(Capabilities0_FilesSharing_Sharebymail_ExpireDate.serializer)
      ..addBuilderFactory(const FullType(BuiltList, [FullType(Never)]), ListBuilder<Never>.new)
      ..add($7f1b9936cf688676379074249fff891bExtension._serializer))
    .build();

/// Serializer for all values in this library.
///
/// Serializes values into the json. Json serialization is more expensive than the built_value wire format.
/// See: [$serializers] for serializing into the `built_value` wire format.
@_i2.visibleForTesting
final Serializers $jsonSerializers = _$jsonSerializers;
final Serializers _$jsonSerializers = (_$serializers.toBuilder()
      ..add(_i3.DynamiteDoubleSerializer())
      ..addPlugin(_i4.StandardJsonPlugin())
      ..addPlugin(const _i3.HeaderPlugin())
      ..addPlugin(const _i3.ContentStringPlugin()))
    .build();
// coverage:ignore-end
