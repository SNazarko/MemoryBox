class CollectionsModel {
  String? titleCollections;
  String? subTitleCollections;
  String? avatarCollections;
  List? audioCollections;

  CollectionsModel({
    this.titleCollections,
    this.subTitleCollections,
    this.avatarCollections,
    this.audioCollections,
  });

  factory CollectionsModel.fromJson(Map<String, dynamic> json) {
    return CollectionsModel(
      titleCollections: json['titleCollections'],
      subTitleCollections: json['subTitleCollections'],
      avatarCollections: json['avatarCollections'],
      audioCollections: json['audioCollections'],
    );
  }

  Map<String, dynamic> toJson() => {
        'titleCollections': titleCollections,
        'subTitleCollections': subTitleCollections,
        'avatarCollections': avatarCollections,
        'audioCollections': audioCollections
      };
}
