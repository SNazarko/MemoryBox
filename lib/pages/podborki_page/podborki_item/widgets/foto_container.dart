import 'package:flutter/cupertino.dart';
import 'package:memory_box/widgets/container_shadow.dart';

class FotoContainer extends StatelessWidget {
  FotoContainer({Key? key}) : super(key: key);
  String? singleImage;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        top: 130.0,
        right: 15.0,
      ),
      child: ContainerShadow(
        image: Image.network(
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fbigpicture.ru%2F100-luchshix-foto-bez-fotoshopa%2F&psig=AOvVaw1ITqI9ihoRE6ko9u_GEj7S&ust=1645014037801000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCPDDhf3YgfYCFQAAAAAdAAAAABAD',
          fit: BoxFit.fitWidth,
        ),
        width: screenWidth * 0.955,
        height: 200.0,
        widget: const Text(''),
        radius: 20.0,
      ),
    );
  }
}
