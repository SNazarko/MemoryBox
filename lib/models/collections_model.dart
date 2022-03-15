class CollectionsModel {
  String? id;
  String? titleCollections;
  String? subTitleCollections;
  String? avatarCollections;
  String? data;
  int? qualityCollections;
  bool? doneCollection;

  CollectionsModel({
    this.id,
    this.titleCollections,
    this.subTitleCollections,
    this.avatarCollections,
    this.data,
    this.qualityCollections,
    this.doneCollection,
  });

  factory CollectionsModel.fromJson(Map<String, dynamic> json) {
    return CollectionsModel(
      id: json['id'],
      titleCollections: json['titleCollections'],
      subTitleCollections: json['subTitleCollections'],
      avatarCollections: json['avatarCollections'],
      data: json['data'],
      qualityCollections: json['qualityCollections'],
      doneCollection: json['doneCollection'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'titleCollections': titleCollections,
        'subTitleCollections': subTitleCollections,
        'avatarCollections': avatarCollections,
        'data': data,
        'qualityCollections': qualityCollections,
        'doneCollection': doneCollection
      };
}
