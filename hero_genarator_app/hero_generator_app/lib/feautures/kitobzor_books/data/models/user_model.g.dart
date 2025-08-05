// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: (json['id'] as num?)?.toInt(),
  bio: json['bio'],
  appPhoneNumber: json['appPhoneNumber'],
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  picture: json['picture'] as String?,
  region: json['region'],
  district: json['district'],
  point: json['point'],
  locationText: json['locationText'],
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bio': instance.bio,
      'appPhoneNumber': instance.appPhoneNumber,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'picture': instance.picture,
      'region': instance.region,
      'district': instance.district,
      'point': instance.point,
      'locationText': instance.locationText,
    };
