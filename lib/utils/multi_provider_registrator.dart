import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/edit_dog_service.dart';
import 'package:flutter_mobile_app/service/edit_user_service.dart';
import 'package:flutter_mobile_app/service/exercises_service.dart';
import 'package:flutter_mobile_app/service/map_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_chat_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_notyfication_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_room_service.dart';
import 'package:flutter_mobile_app/service/missing_dog_service.dart';
import 'package:flutter_mobile_app/service/scaffold_service.dart';
import 'package:flutter_mobile_app/service/swipe_profile_service.dart';

class MultiProviderRegistrator extends MultiProvider {
  MultiProviderRegistrator({super.key, this.child, this.builder})
      : super(child: child, builder: builder, providers: [
          ChangeNotifierProvider(create: (_) => ExercisesService()),
          ChangeNotifierProvider(create: (_) => SwipeProfileService()),
          ChangeNotifierProvider(create: (_) => MissingDogService()),
          ChangeNotifierProvider(create: (_) => EditDogService()),
          ChangeNotifierProvider(create: (_) => EditUserService()),
          ChangeNotifierProvider(create: (_) => MessangerConnectionService()),
          ChangeNotifierProvider(create: (_) => ScaffoldService()),
          ChangeNotifierProvider(create: (_) => MapService()),
          ChangeNotifierProxyProvider<MessangerConnectionService,
                  MessangerChatService>(
              create: (_) => MessangerChatService(),
              update: (_, messangerService, messangerChatService) =>
                  messangerChatService!..update(messangerService)),
          ChangeNotifierProxyProvider<MessangerConnectionService,
              MessangerNotificationService>(
            create: (_) => MessangerNotificationService(),
            update: (_, messangerService, messangerNotificationService) =>
                messangerNotificationService!..update(messangerService),
          ),
          ChangeNotifierProxyProvider2<MessangerConnectionService,
              MessangerChatService, MessangerRoomService>(
            create: (_) => MessangerRoomService(),
            update: (_, messangerService, messangerChatService,
                    messangerRoomService) =>
                messangerRoomService!
                  ..update(messangerService, messangerChatService),
          ),
        ]);
  final Widget? child;
  final TransitionBuilder? builder;
}
