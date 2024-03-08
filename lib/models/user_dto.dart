import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final String? id;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final String? name;

  const UserDto({this.id, this.imageUrl, this.name});

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
  factory UserDto.fixture() => const UserDto(
        id: 'userId',
        name: 'George M.',
        imageUrl: 'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/400.jpg',
      );

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
