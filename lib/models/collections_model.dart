class CollectionsModel {
  String? titleCollections;
  String? subTitleCollections;
  String? avatarCollections;
  String? data;
  int? qualityCollections;
  bool? doneCollection;

  CollectionsModel({
    this.titleCollections,
    this.subTitleCollections,
    this.avatarCollections,
    this.data,
    this.qualityCollections,
    this.doneCollection,
  });

  factory CollectionsModel.fromJson(Map<String, dynamic> json) {
    return CollectionsModel(
      titleCollections: json['titleCollections'],
      subTitleCollections: json['subTitleCollections'],
      avatarCollections: json['avatarCollections'],
      data: json['data'],
      qualityCollections: json['qualityCollections'],
      doneCollection: json['doneCollection'],
    );
  }

  Map<String, dynamic> toJson() => {
        'titleCollections': titleCollections,
        'subTitleCollections': subTitleCollections,
        'avatarCollections': avatarCollections,
        'data': data,
        'qualityCollections': qualityCollections,
        'doneCollection': doneCollection
      };
}
