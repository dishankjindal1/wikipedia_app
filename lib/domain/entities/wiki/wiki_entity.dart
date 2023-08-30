import 'package:wikipedia_app/core/resources/entity/abstract_base_entity.dart';

class WikiEntity extends BaseEntity {
  final String title;
  final String description;
  final String imageUrl;

  const WikiEntity({
    super.hasError,
    super.errorMessage,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory WikiEntity.mock() {
    return const WikiEntity(
      title: 'Albert Einstein',
      description:
          'German-born theoretical physicist; developer of the theory of relativity (1879–1955)',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Einstein_1921_by_F_Schmutzer_-_restoration.jpg/50px-Einstein_1921_by_F_Schmutzer_-_restoration.jpg',
    );
  }

  factory WikiEntity.error({required String errorMessage}) {
    return WikiEntity(
      hasError: true,
      errorMessage: errorMessage,
      title: '----',
      description: '----',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Einstein_1921_by_F_Schmutzer_-_restoration.jpg/50px-Einstein_1921_by_F_Schmutzer_-_restoration.jpg',
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        imageUrl,
      ];
}
