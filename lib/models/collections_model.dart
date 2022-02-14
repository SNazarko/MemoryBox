class CollectionsModel {
  String? titleCollections;
  String? subTitleCollections;
  String? avatarCollections;
  int? qualityCollections;

  CollectionsModel({
    this.titleCollections,
    this.subTitleCollections,
    this.avatarCollections,
    this.qualityCollections,
  });

  factory CollectionsModel.fromJson(Map<String, dynamic> json) {
    return CollectionsModel(
      titleCollections: json['titleCollections'],
      subTitleCollections: json['subTitleCollections'],
      avatarCollections: json['avatarCollections'],
      qualityCollections: json['qualityCollections'],
    );
  }

  Map<String, dynamic> toJson() => {
        'titleCollections': titleCollections,
        'subTitleCollections': subTitleCollections,
        'avatarCollections': avatarCollections,
        'qualityCollections': qualityCollections
      };
}
