// Use of this source code is governed by a Apache 2.0 license. It can be obtained at `https://www.apache.org/licenses/LICENSE-2.0.html`.

// OpenAPI client generated by Dynamite. Do not manually edit this file.

// ignore_for_file: camel_case_extensions, camel_case_types, discarded_futures
// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: unreachable_switch_case, unused_element

/// Documentation test. Version: 1.0.0.
/// Values are inspired by the petstore example.
///
/// A sample API that uses a petstore as an example to demonstrate features in the OpenAPI 3.0 specification.
///
/// You can contact the Swagger API Team team under:
///   Email: `apiteam@swagger.io`.
///   Website: `http://swagger.io`.
///
/// Use of this source code is governed by a Apache 2.0 license.
/// It can be obtained at `https://www.apache.org/licenses/LICENSE-2.0.html`.
///
/// Usage of these apis must adhere to the terms of service: `http://swagger.io/terms/`.
library; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' as _i6;
import 'package:dynamite_runtime/built_value.dart' as _i5;
import 'package:dynamite_runtime/http_client.dart' as _i2;
import 'package:dynamite_runtime/utils.dart' as _i4;
import 'package:meta/meta.dart' as _i3;
import 'package:uri/uri.dart' as _i1;

part 'documentation.openapi.g.dart';

/// the root client used for root requests.
class $Client extends _i2.DynamiteClient {
  /// Creates a new `DynamiteClient` for untagged requests.
  $Client(
    super.baseURL, {
    super.baseHeaders,
    super.userAgent,
    super.httpClient,
    super.cookieJar,
  });

  /// Creates a new [$Client] from another [client].
  $Client.fromClient(_i2.DynamiteClient client)
      : super(
          client.baseURL,
          baseHeaders: client.baseHeaders,
          httpClient: client.httpClient,
          cookieJar: client.cookieJar,
          authentications: client.authentications,
        );

  /// the non root client used for other requests.
  late final $NonRootClientClient nonRootClient = $NonRootClientClient(this);

  /// An optional, string summary, intended to apply to all operations in this path.
  ///
  /// Returns all pets from the system that the user has access to.
  /// Nam sed condimentum est. Maecenas tempor sagittis sapien, nec rhoncus sem sagittis sit amet. Aenean at gravida augue, ac iaculis sem. Curabitur odio lorem, ornare eget elementum nec, cursus id lectus. Duis mi turpis, pulvinar ac eros ac, tincidunt varius justo. In hac habitasse platea dictumst. Integer at adipiscing ante, a sagittis ligula. Aenean pharetra tempor ante molestie imperdiet. Vivamus id aliquam diam. Cras quis velit non tortor eleifend sagittis. Praesent at enim pharetra urna volutpat venenatis eget eget mauris. In eleifend fermentum facilisis. Praesent enim enim, gravida ac sodales sed, placerat id erat. Suspendisse lacus dolor, consectetur non augue vel, vehicula interdum libero. Morbi euismod sagittis libero sed lacinia.
  ///
  /// Sed tempus felis lobortis leo pulvinar rutrum. Nam mattis velit nisl, eu condimentum ligula luctus nec. Phasellus semper velit eget aliquet faucibus. In a mattis elit. Phasellus vel urna viverra, condimentum lorem id, rhoncus nibh. Ut pellentesque posuere elementum. Sed a varius odio. Morbi rhoncus ligula libero, vel eleifend nunc tristique vitae. Fusce et sem dui. Aenean nec scelerisque tortor. Fusce malesuada accumsan magna vel tempus. Quisque mollis felis eu dolor tristique, sit amet auctor felis gravida. Sed libero lorem, molestie sed nisl in, accumsan tempor nisi. Fusce sollicitudin massa ut lacinia mattis. Sed vel eleifend lorem. Pellentesque vitae felis pretium, pulvinar elit eu, euismod sapien.
  ///
  ///
  /// Returns a [Future] containing a `DynamiteResponse` with the status code, deserialized body and headers.
  /// Throws a `DynamiteApiException` if the API call does not return an expected status code.
  ///
  /// Parameters:
  ///   * [tags] tags to filter by.
  ///   * [limit] maximum number of results to return.
  ///
  /// Status codes:
  ///   * default: finds an object
  ///
  /// See:
  ///  * [findValuesRaw] for an experimental operation that returns a `DynamiteRawResponse` that can be serialized.
  Future<_i2.DynamiteResponse<Object1, void>> findValues({
    BuiltList<String>? tags,
    int? limit,
  }) async {
    final rawResponse = findValuesRaw(
      tags: tags,
      limit: limit,
    );

    return rawResponse.future;
  }

  /// An optional, string summary, intended to apply to all operations in this path.
  ///
  /// Returns all pets from the system that the user has access to.
  /// Nam sed condimentum est. Maecenas tempor sagittis sapien, nec rhoncus sem sagittis sit amet. Aenean at gravida augue, ac iaculis sem. Curabitur odio lorem, ornare eget elementum nec, cursus id lectus. Duis mi turpis, pulvinar ac eros ac, tincidunt varius justo. In hac habitasse platea dictumst. Integer at adipiscing ante, a sagittis ligula. Aenean pharetra tempor ante molestie imperdiet. Vivamus id aliquam diam. Cras quis velit non tortor eleifend sagittis. Praesent at enim pharetra urna volutpat venenatis eget eget mauris. In eleifend fermentum facilisis. Praesent enim enim, gravida ac sodales sed, placerat id erat. Suspendisse lacus dolor, consectetur non augue vel, vehicula interdum libero. Morbi euismod sagittis libero sed lacinia.
  ///
  /// Sed tempus felis lobortis leo pulvinar rutrum. Nam mattis velit nisl, eu condimentum ligula luctus nec. Phasellus semper velit eget aliquet faucibus. In a mattis elit. Phasellus vel urna viverra, condimentum lorem id, rhoncus nibh. Ut pellentesque posuere elementum. Sed a varius odio. Morbi rhoncus ligula libero, vel eleifend nunc tristique vitae. Fusce et sem dui. Aenean nec scelerisque tortor. Fusce malesuada accumsan magna vel tempus. Quisque mollis felis eu dolor tristique, sit amet auctor felis gravida. Sed libero lorem, molestie sed nisl in, accumsan tempor nisi. Fusce sollicitudin massa ut lacinia mattis. Sed vel eleifend lorem. Pellentesque vitae felis pretium, pulvinar elit eu, euismod sapien.
  ///
  ///
  /// This method and the response it returns is experimental. The API might change without a major version bump.
  ///
  /// Returns a [Future] containing a `DynamiteRawResponse` with the raw `HttpClientResponse` and serialization helpers.
  /// Throws a `DynamiteApiException` if the API call does not return an expected status code.
  ///
  /// Parameters:
  ///   * [tags] tags to filter by.
  ///   * [limit] maximum number of results to return.
  ///
  /// Status codes:
  ///   * default: finds an object
  ///
  /// See:
  ///  * [findValues] for an operation that returns a `DynamiteResponse` with a stable API.
  @_i3.experimental
  _i2.DynamiteRawResponse<Object1, void> findValuesRaw({
    BuiltList<String>? tags,
    int? limit,
  }) {
    final _parameters = <String, dynamic>{};
    const _headers = <String, String>{
      'Accept': 'application/json',
    };

    final $tags = _$jsonSerializers.serialize(tags, specifiedType: const FullType(BuiltList, [FullType(String)]));
    _parameters['tags'] = $tags;

    final $limit = _$jsonSerializers.serialize(limit, specifiedType: const FullType(int));
    _parameters['limit'] = $limit;

    final _path = _i1.UriTemplate('/{?tags*,limit*}').expand(_parameters);
    return _i2.DynamiteRawResponse<Object1, void>(
      response: executeRequest(
        'get',
        _path,
        _headers,
        null,
        null,
      ),
      bodyType: const FullType(Object1),
      headersType: null,
      serializers: _$jsonSerializers,
    );
  }
}

/// the non root client used for other requests.
class $NonRootClientClient {
  /// Creates a new `DynamiteClient` for non_root_client requests.
  $NonRootClientClient(this._rootClient);

  final $Client _rootClient;

  /// Do something really cool.
  ///
  /// Returns a [Future] containing a `DynamiteResponse` with the status code, deserialized body and headers.
  /// Throws a `DynamiteApiException` if the API call does not return an expected status code.
  ///
  /// Status codes:
  ///   * default: finds an object
  ///
  /// See:
  ///  * [setModeRaw] for an experimental operation that returns a `DynamiteRawResponse` that can be serialized.
  Future<_i2.DynamiteResponse<Object1, void>> setMode() async {
    final rawResponse = setModeRaw();

    return rawResponse.future;
  }

  /// Do something really cool.
  ///
  /// This method and the response it returns is experimental. The API might change without a major version bump.
  ///
  /// Returns a [Future] containing a `DynamiteRawResponse` with the raw `HttpClientResponse` and serialization helpers.
  /// Throws a `DynamiteApiException` if the API call does not return an expected status code.
  ///
  /// Status codes:
  ///   * default: finds an object
  ///
  /// See:
  ///  * [setMode] for an operation that returns a `DynamiteResponse` with a stable API.
  @_i3.experimental
  _i2.DynamiteRawResponse<Object1, void> setModeRaw() {
    const _headers = <String, String>{
      'Accept': 'application/json',
    };

    const _path = '/other-endpoint';
    return _i2.DynamiteRawResponse<Object1, void>(
      response: _rootClient.executeRequest(
        'post',
        _path,
        _headers,
        null,
        null,
      ),
      bodyType: const FullType(Object1),
      headersType: null,
      serializers: _$jsonSerializers,
    );
  }
}

// ignore: public_member_api_docs
typedef Redirect = Object2;

/// A representation of the second Object type.
@BuiltValue(instantiable: false)
abstract interface class $Object2Interface {
  /// The name of this object.
  String get name;

  /// The tag of an Object2 object.
  String? get tag;
}

/// A representation of the second Object type.
abstract class Object2 implements $Object2Interface, Built<Object2, Object2Builder> {
  /// Creates a new Object2 object using the builder pattern.
  factory Object2([void Function(Object2Builder)? b]) = _$Object2;

  const Object2._();

  /// Creates a new object from the given [json] data.
  ///
  /// Use [toJson] to serialize it back into json.
  factory Object2.fromJson(Map<String, dynamic> json) => _$jsonSerializers.deserializeWith(serializer, json)!;

  /// Parses this object into a json like map.
  ///
  /// Use the fromJson factory to revive it again.
  Map<String, dynamic> toJson() => _$jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;

  /// Serializer for Object2.
  static Serializer<Object2> get serializer => _$object2Serializer;
}

/// A representation of the main object.
@BuiltValue(instantiable: false)
abstract interface class $Object1Interface implements $Object2Interface {
  /// The uuid in an UUIDv4 format.
  int get id;
}

/// A representation of the main object.
abstract class Object1 implements $Object1Interface, Built<Object1, Object1Builder> {
  /// Creates a new Object1 object using the builder pattern.
  factory Object1([void Function(Object1Builder)? b]) = _$Object1;

  const Object1._();

  /// Creates a new object from the given [json] data.
  ///
  /// Use [toJson] to serialize it back into json.
  factory Object1.fromJson(Map<String, dynamic> json) => _$jsonSerializers.deserializeWith(serializer, json)!;

  /// Parses this object into a json like map.
  ///
  /// Use the fromJson factory to revive it again.
  Map<String, dynamic> toJson() => _$jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;

  /// Serializer for Object1.
  static Serializer<Object1> get serializer => _$object1Serializer;
}

/// An Object to test the documentation of someOf extension methods and typdefs.
typedef Object3 = ({int? $int, String? string});

/// The measured skill for hunting.
class HuntingSkill extends EnumClass {
  const HuntingSkill._(super.name);

  /// `clueless`
  static const HuntingSkill clueless = _$huntingSkillClueless;

  /// `lazy`
  static const HuntingSkill lazy = _$huntingSkillLazy;

  /// `adventurous`
  static const HuntingSkill adventurous = _$huntingSkillAdventurous;

  /// `aggressive`
  static const HuntingSkill aggressive = _$huntingSkillAggressive;

  /// Returns a set with all values this enum contains.
  static BuiltSet<HuntingSkill> get values => _$huntingSkillValues;

  /// Returns the enum value associated to the [name].
  static HuntingSkill valueOf(String name) => _$valueOfHuntingSkill(name);

  /// Returns the serialized value of this enum value.
  dynamic get value => _$jsonSerializers.serializeWith(serializer, this)! as dynamic;

  /// Serializer for HuntingSkill.
  @BuiltValueSerializer(custom: true)
  static Serializer<HuntingSkill> get serializer => const _$HuntingSkillSerializer();
}

class _$HuntingSkillSerializer implements PrimitiveSerializer<HuntingSkill> {
  const _$HuntingSkillSerializer();

  static const Map<HuntingSkill, Object> _toWire = <HuntingSkill, Object>{
    HuntingSkill.clueless: 'clueless',
    HuntingSkill.lazy: 'lazy',
    HuntingSkill.adventurous: 'adventurous',
    HuntingSkill.aggressive: 'aggressive',
  };

  static const Map<Object, HuntingSkill> _fromWire = <Object, HuntingSkill>{
    'clueless': HuntingSkill.clueless,
    'lazy': HuntingSkill.lazy,
    'adventurous': HuntingSkill.adventurous,
    'aggressive': HuntingSkill.aggressive,
  };

  @override
  Iterable<Type> get types => const [HuntingSkill];

  @override
  String get wireName => 'HuntingSkill';

  @override
  Object serialize(
    Serializers serializers,
    HuntingSkill object, {
    FullType specifiedType = FullType.unspecified,
  }) =>
      _toWire[object]!;

  @override
  HuntingSkill deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) =>
      _fromWire[serialized]!;
}

/// Serialization extension for `Object3`.
extension $Object3Extension on Object3 {
  /// Serializer for Object3.
  @BuiltValueSerializer(custom: true)
  static Serializer<Object3> get serializer => $b2c4857c0136baea42828d89c87c757dExtension._serializer;

  /// Creates a new object from the given [json] data.
  ///
  /// Use `toJson` to serialize it back into json.
  static Object3 fromJson(Object? json) => $b2c4857c0136baea42828d89c87c757dExtension._fromJson(json);
}

typedef _$b2c4857c0136baea42828d89c87c757d = ({int? $int, String? string});

/// @nodoc
// ignore: library_private_types_in_public_api
extension $b2c4857c0136baea42828d89c87c757dExtension on _$b2c4857c0136baea42828d89c87c757d {
  List<dynamic> get _values => [$int, string];

  /// {@macro Dynamite.validateOneOf}
  void validateOneOf() => _i4.validateOneOf(_values);

  /// {@macro Dynamite.validateAnyOf}
  void validateAnyOf() => _i4.validateAnyOf(_values);
  static Serializer<_$b2c4857c0136baea42828d89c87c757d> get _serializer =>
      const _$b2c4857c0136baea42828d89c87c757dSerializer();
  static _$b2c4857c0136baea42828d89c87c757d _fromJson(Object? json) =>
      _$jsonSerializers.deserializeWith(_serializer, json)!;

  /// Parses this object into a json like map.
  ///
  /// Use the fromJson factory to revive it again.
  Object? toJson() => _$jsonSerializers.serializeWith(_serializer, this);
}

class _$b2c4857c0136baea42828d89c87c757dSerializer implements PrimitiveSerializer<_$b2c4857c0136baea42828d89c87c757d> {
  const _$b2c4857c0136baea42828d89c87c757dSerializer();

  @override
  Iterable<Type> get types => const [_$b2c4857c0136baea42828d89c87c757d];

  @override
  String get wireName => r'_$b2c4857c0136baea42828d89c87c757d';

  @override
  Object serialize(
    Serializers serializers,
    _$b2c4857c0136baea42828d89c87c757d object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    dynamic value;
    value = object.$int;
    if (value != null) {
      return serializers.serialize(value, specifiedType: const FullType(int))!;
    }
    value = object.string;
    if (value != null) {
      return serializers.serialize(value, specifiedType: const FullType(String))!;
    }
// Should not be possible after validation.
    throw StateError('Tried to serialize without any value.');
  }

  @override
  _$b2c4857c0136baea42828d89c87c757d deserialize(
    Serializers serializers,
    Object data, {
    FullType specifiedType = FullType.unspecified,
  }) {
    int? $int;
    try {
      $int = serializers.deserialize(data, specifiedType: const FullType(int))! as int;
    } catch (_) {}
    String? string;
    try {
      string = serializers.deserialize(data, specifiedType: const FullType(String))! as String;
    } catch (_) {}
    return ($int: $int, string: string);
  }
}

// coverage:ignore-start
/// Serializer for all values in this library.
///
/// Serializes values into the `built_value` wire format.
/// See: [$jsonSerializers] for serializing into json.
@_i3.visibleForTesting
final Serializers $serializers = _$serializers;
final Serializers _$serializers = (Serializers().toBuilder()
      ..addBuilderFactory(const FullType(BuiltList, [FullType(String)]), ListBuilder<String>.new)
      ..addBuilderFactory(const FullType(Object1), Object1Builder.new)
      ..add(Object1.serializer)
      ..addBuilderFactory(const FullType(Object2), Object2Builder.new)
      ..add(Object2.serializer)
      ..add($b2c4857c0136baea42828d89c87c757dExtension._serializer)
      ..add(HuntingSkill.serializer))
    .build();

/// Serializer for all values in this library.
///
/// Serializes values into the json. Json serialization is more expensive than the built_value wire format.
/// See: [$serializers] for serializing into the `built_value` wire format.
@_i3.visibleForTesting
final Serializers $jsonSerializers = _$jsonSerializers;
final Serializers _$jsonSerializers = (_$serializers.toBuilder()
      ..add(_i5.DynamiteDoubleSerializer())
      ..addPlugin(_i6.StandardJsonPlugin())
      ..addPlugin(const _i5.HeaderPlugin())
      ..addPlugin(const _i5.ContentStringPlugin()))
    .build();
// coverage:ignore-end
