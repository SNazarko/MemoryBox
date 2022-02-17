class CollectionsModel {
  String? titleCollections;
  String? subTitleCollections;
  String? avatarCollections;
  String? data;
  int? qualityCollections;

  CollectionsModel({
    this.titleCollections,
    this.subTitleCollections,
    this.avatarCollections,
    this.data,
    this.qualityCollections,
  });

  factory CollectionsModel.fromJson(Map<String, dynamic> json) {
    return CollectionsModel(
      titleCollections: json['titleCollections'],
      subTitleCollections: json['subTitleCollections'],
      avatarCollections: json['avatarCollections'],
      data: json['data'],
      qualityCollections: json['qualityCollections'],
    );
  }

  Map<String, dynamic> toJson() => {
        'titleCollections': titleCollections,
        'subTitleCollections': subTitleCollections,
        'avatarCollections': avatarCollections,
        'data': data,
        'qualityCollections': qualityCollections
      };
}
