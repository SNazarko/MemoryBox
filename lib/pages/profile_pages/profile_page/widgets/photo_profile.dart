import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/profile_page/profile_page_bloc.dart';

class PhotoProfileProfile extends StatelessWidget {
  const PhotoProfileProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                SizedBox(
                    width: 200.0,
                    height: 200.0,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        child: state.image == 'assets/images/profile_avatar.png'
                            ? Image.asset(
                                state.image!,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                state.image!,
                                fit: BoxFit.cover,
                              ))),
              ],
            ),
          ),
        );
      },
    );
  }
}
