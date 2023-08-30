import 'dart:convert';

import 'package:wikipedia_app/domain/entities/wiki/wiki_entity.dart';

class WikiModel extends WikiEntity {
  const WikiModel({
    required super.title,
    required super.description,
    required super.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory WikiModel.fromMap(Map<String, dynamic> map) {
    return WikiModel(
      title: map['title'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  static List<WikiModel> parseToList(Map<String, dynamic> map) {
    final pages =
        (map['query'] as Map<String, dynamic>)['pages'] as List<dynamic>;

    /// processing
    final result = pages
        .map<WikiModel?>((e) {
          try {
            final res = e as Map<String, dynamic>;

            /// Title
            final title = res['title'] as String;

            /// Description
            final terms = res['terms'] as Map<String, dynamic>;
            final desciptions = (terms['description'] as List<dynamic>)
                .map((e) => e as String)
                .toList();
            final String desc;
            if (desciptions.isNotEmpty) {
              desc = desciptions.first;
            } else {
              desc = 'No Description';
            }

            /// Image Url
            final thumbnail = res['thumbnail'] as Map<String, dynamic>;
            final imageUrl = thumbnail['source'] as String;

            return WikiModel(
                title: title, description: desc, imageUrl: imageUrl);
          } catch (e) {
            return null;
          }
        })
        .where((element) => element != null)
        .toList()
        .cast<WikiModel>();

    return result;
  }

  String toJson() => json.encode(toMap());

  factory WikiModel.fromJson(String source) =>
      WikiModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
