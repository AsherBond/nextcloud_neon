// ignore_for_file: camel_case_extensions, camel_case_types, discarded_futures
// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: public_member_api_docs, unreachable_switch_case
// ignore_for_file: unused_element

library some_of_openapi;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:dynamite_runtime/built_value.dart';
import 'package:dynamite_runtime/utils.dart' as dynamite_utils;
import 'package:meta/meta.dart';

part 'some_of.openapi.g.dart';

@BuiltValue(instantiable: false)
abstract interface class $OneValueSomeOfInObjectInterface {
  @BuiltValueField(wireName: 'OneValue')
  int get oneValue;
  @BuiltValueField(wireName: 'IntDouble')
  num get intDouble;
  @BuiltValueField(wireName: 'IntDoubleString')
  OneValueSomeOfInObject_IntDoubleString? get intDoubleString;
}

abstract class OneValueSomeOfInObject
    implements $OneValueSomeOfInObjectInterface, Built<OneValueSomeOfInObject, OneValueSomeOfInObjectBuilder> {
  factory OneValueSomeOfInObject([void Function(OneValueSomeOfInObjectBuilder)? b]) = _$OneValueSomeOfInObject;

  const OneValueSomeOfInObject._();

  factory OneValueSomeOfInObject.fromJson(Map<String, dynamic> json) =>
      jsonSerializers.deserializeWith(serializer, json)!;

  Map<String, dynamic> toJson() => jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;

  static Serializer<OneValueSomeOfInObject> get serializer => _$oneValueSomeOfInObjectSerializer;

  @BuiltValueHook(finalizeBuilder: true)
  static void _validate(OneValueSomeOfInObjectBuilder b) {
    b.intDoubleString?.validateOneOf();
  }
}

typedef OneOfIntDoubleOther = ({num? $num, String? string});

extension $OneOfIntDoubleOtherExtension on OneOfIntDoubleOther {
  static Serializer<OneOfIntDoubleOther> get serializer => $b6d67dc2a96424d2f407f8e51557f3deExtension._serializer;
  static OneOfIntDoubleOther fromJson(Object? json) => $b6d67dc2a96424d2f407f8e51557f3deExtension._fromJson(json);
}

typedef AnyOfIntDoubleOther = ({num? $num, String? string});

extension $AnyOfIntDoubleOtherExtension on AnyOfIntDoubleOther {
  static Serializer<AnyOfIntDoubleOther> get serializer => $b6d67dc2a96424d2f407f8e51557f3deExtension._serializer;
  static AnyOfIntDoubleOther fromJson(Object? json) => $b6d67dc2a96424d2f407f8e51557f3deExtension._fromJson(json);
}

typedef OneValueSomeOfInObject_IntDoubleString = ({num? $num, String? string});

extension $OneValueSomeOfInObject_IntDoubleStringExtension on OneValueSomeOfInObject_IntDoubleString {
  static Serializer<OneValueSomeOfInObject_IntDoubleString> get serializer =>
      $b6d67dc2a96424d2f407f8e51557f3deExtension._serializer;
  static OneValueSomeOfInObject_IntDoubleString fromJson(Object? json) =>
      $b6d67dc2a96424d2f407f8e51557f3deExtension._fromJson(json);
}

typedef _$b6d67dc2a96424d2f407f8e51557f3de = ({num? $num, String? string});

/// @nodoc
// ignore: library_private_types_in_public_api
extension $b6d67dc2a96424d2f407f8e51557f3deExtension on _$b6d67dc2a96424d2f407f8e51557f3de {
  List<dynamic> get _values => [$num, string];
  void validateOneOf() => dynamite_utils.validateOneOf(_values);
  void validateAnyOf() => dynamite_utils.validateAnyOf(_values);
  static Serializer<_$b6d67dc2a96424d2f407f8e51557f3de> get _serializer =>
      const _$b6d67dc2a96424d2f407f8e51557f3deSerializer();
  static _$b6d67dc2a96424d2f407f8e51557f3de _fromJson(Object? json) =>
      jsonSerializers.deserializeWith(_serializer, json)!;
  Object? toJson() => jsonSerializers.serializeWith(_serializer, this);
}

class _$b6d67dc2a96424d2f407f8e51557f3deSerializer implements PrimitiveSerializer<_$b6d67dc2a96424d2f407f8e51557f3de> {
  const _$b6d67dc2a96424d2f407f8e51557f3deSerializer();

  @override
  Iterable<Type> get types => const [_$b6d67dc2a96424d2f407f8e51557f3de];

  @override
  String get wireName => r'_$b6d67dc2a96424d2f407f8e51557f3de';

  @override
  Object serialize(
    Serializers serializers,
    _$b6d67dc2a96424d2f407f8e51557f3de object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    dynamic value;
    value = object.$num;
    if (value != null) {
      return serializers.serialize(value, specifiedType: const FullType(num))!;
    }
    value = object.string;
    if (value != null) {
      return serializers.serialize(value, specifiedType: const FullType(String))!;
    }
// Should not be possible after validation.
    throw StateError('Tried to serialize without any value.');
  }

  @override
  _$b6d67dc2a96424d2f407f8e51557f3de deserialize(
    Serializers serializers,
    Object data, {
    FullType specifiedType = FullType.unspecified,
  }) {
    num? $num;
    try {
      $num = serializers.deserialize(data, specifiedType: const FullType(num))! as num;
    } catch (_) {}
    String? string;
    try {
      string = serializers.deserialize(data, specifiedType: const FullType(String))! as String;
    } catch (_) {}
    return ($num: $num, string: string);
  }
}

// coverage:ignore-start
@visibleForTesting
final Serializers serializers = (Serializers().toBuilder()
      ..add($b6d67dc2a96424d2f407f8e51557f3deExtension._serializer)
      ..addBuilderFactory(const FullType(OneValueSomeOfInObject), OneValueSomeOfInObjectBuilder.new)
      ..add(OneValueSomeOfInObject.serializer))
    .build();
@visibleForTesting
final Serializers jsonSerializers = (serializers.toBuilder()
      ..add(DynamiteDoubleSerializer())
      ..addPlugin(StandardJsonPlugin())
      ..addPlugin(const HeaderPlugin())
      ..addPlugin(const ContentStringPlugin()))
    .build();
// coverage:ignore-end
