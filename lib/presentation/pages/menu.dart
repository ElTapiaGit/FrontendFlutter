import 'package:flutter/material.dart';
import 'package:iuapp/presentation/pages/calendar.dart';
import 'package:iuapp/presentation/pages/estadistic.dart';
import '../layout/sidebar.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';
import '../constants/theme.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // agregamos el sidebar
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text('Menu Principal', style: TextStyle(color: AppColors.textWhite),), 
        backgroundColor: AppColors.backroundGradient.colors[0],
      ),
    body: Center(
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backroundGradient,
        ),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserProfileAvatar(
        avatarUrl: 'https://picsum.photos/id/237/5000/5000',
        onAvatarTap: () {
          print('Avatar Tapped..');
        },
        notificationCount: 6,
        notificationBubbleTextStyle: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        avatarSplashColor: const Color.fromARGB(255, 19, 37, 234),
        radius: 100,
        isActivityIndicatorSmall: false,
        avatarBorderData: AvatarBorderData(
          borderColor: const Color.fromARGB(255, 204, 10, 10),
          borderWidth: 5.0,
        ),
      ),
           Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              child: Text('Calendario'),
              onPressed: () {
                //redireccionamento a la siguiente pagina
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalendarPage()),
                );
              },
            ),
          ),
              Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              child: Text('Estadisticas'),
              onPressed: () {
                //redireccionamento a la siguiente pagina
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EstadisticPage()),
                );
              },
            ),
          ),
        ],
      ),
    ),
  )
    );
}
}


