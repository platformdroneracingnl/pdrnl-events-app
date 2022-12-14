import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// My package imports
import 'package:pdrnl_events_app/utils/constants.dart';
import 'package:pdrnl_events_app/models/user.dart';
import 'package:pdrnl_events_app/providers/profile_provider.dart';
import 'package:pdrnl_events_app/providers/auth_provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<ProfileProvider>(context, listen: false);

    return FutureBuilder(
      future: userProvider.getUser(authProvider.token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Consumer<ProfileProvider>(
            builder: (ctx, profileData, _) {
              final LocalUser profile = profileData.user;
              return SizedBox(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.only(top: 30),
                      child: Stack(
                        children: <Widget>[
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage('https://picsum.photos/200'),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Styles.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                heightFactor: 20,
                                widthFactor: 20,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      profile.name,
                      style: Styles.headLineStyle1,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      profile.email,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
