import 'package:image_picker/image_picker.dart';

class ImagePick {
  Future<XFile?> singleImagePick() async {
    return await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );
  }
}
