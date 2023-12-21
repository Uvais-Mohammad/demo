import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http_util_package/http_util.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sf_chat_im/shared/cubits/download_cubit/download_cubit.dart';
import 'package:sf_chat_im/shared/cubits/sf_cubit/sf_cubit.dart';
import 'package:sf_chat_im/features/chat/logic/chat_other_cubit/chat_other_cubit.dart';
import 'package:sf_chat_im/features/chat/logic/group_manage_bloc/group_mange_bloc.dart';
import 'package:sf_chat_im/features/chat/logic/pick_file/pick_file_cubit.dart';
import 'package:sf_chat_im/features/envelopTransfer/cubit/envelopTransfer_cubit.dart';
import 'package:sf_chat_im/features/envelopTransfer/repository/i__envelop_transfer_repo.dart';
import 'package:sf_chat_im/features/envelope/cubit/envelope_cubit.dart';
import 'package:sf_chat_im/features/envelope/repository/i_envelope_repo.dart';
import 'package:sf_chat_im/features/friends/friendsList/blocs/friends_bloc/friends_bloc.dart';
import 'package:sf_chat_im/features/friends/friendsList/cubit/report_user_cubit.dart';
import 'package:sf_chat_im/features/friends/friendsList/repository/i_friends_repository.dart';
import 'package:sf_chat_im/features/login/Logic/login_with_username_cubit/login_cubit.dart';
import 'package:sf_chat_im/features/login/Logic/previous_login_activity_cubit/previous_login_activity_cubit.dart';
import 'package:sf_chat_im/features/login/repository/login_repository.dart';
import 'package:sf_chat_im/features/main/screens/main_screen.dart';
import 'package:sf_chat_im/features/paymentCenter/cubit/payment_center_cubit.dart';
import 'package:sf_chat_im/features/paymentCenter/repository/i_payment_center_repo.dart';
import 'package:sf_chat_im/features/settings/blocs/bloc/conflict_login_bloc.dart';
import 'package:sf_chat_im/features/settings/blocs/logout/logout_cubit.dart';
import 'package:sf_chat_im/features/splash/cubit/splash_cubit.dart';
import 'package:sf_chat_im/features/splash/repository/i_splash_repo.dart';
import 'package:sf_chat_im/features/transfer/cubit/transfer_cubit.dart';
import 'package:sf_chat_im/features/transfer/repository/i_transfer_repo.dart';
import 'package:sf_chat_im/features/wallets/cubit/wallet_cubit.dart';
import 'package:sf_chat_im/features/wallets/repository/i_wallet_repo.dart';
import 'package:sf_chat_im/firebase_options.dart';
import 'package:sf_chat_im/my_app.dart';
import 'package:sf_chat_im/shared/constants/string_constants.dart';
import 'package:sf_chat_im/shared/cubits/country_cubit/country_cubit.dart';
import 'package:sf_chat_im/shared/services/isar_service/isar_service.dart';
import 'package:sf_chat_im/shared/services/notification/i_notification.dart';
import 'package:sf_chat_im/shared/services/secure_storage_service/i_secure_storage.dart';
import 'package:sf_chat_im/shared/services/secure_storage_service/secure_storage_keys.dart';
import 'package:sf_chat_im/shared/services/service_locator.dart';
import 'package:workmanager/workmanager.dart';
import 'package:xmpp_stone/xmpp_stone.dart';

const fetchBackground = "fetchBackground";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackground:
        // Code to run in background
        break;
    }
    return Future.value(true);
  });
}

//TODo:proof this is latest code1
void deleteToken() {
  locator<ISecureStorageService>().delete(key: SecureStorageKeys.token);
}

Future<String> getToken() async {
  final token = await locator<ISecureStorageService>()
          .read(key: SecureStorageKeys.token) ??
      '';
  final finalToken = json.decode(token);
  log('all token calls here');
  return finalToken;
}

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await FlutterDownloader.initialize(debug: kDebugMode, ignoreSsl: true);
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);
  FlutterDownloader.registerCallback(MainScreen2.downloadCallback);
  if (Platform.isAndroid) {
    await Workmanager().registerPeriodicTask(
      "1",
      fetchBackground,
      frequency: Duration(minutes: 15),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  } else {
    // await Workmanager().registerOneOffTask("1", fetchBackground);
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Future.wait([
    setupLocator(),
    locator<IsarService>().getIsar(),
  ]);
  await locator<IPushNotificationsManager>().init();
  final version =
      await PackageInfo.fromPlatform().then((value) => value.version);
  final buildNumber =
      await PackageInfo.fromPlatform().then((value) => value.buildNumber);
  Log.logLevel = LogLevel.DEBUG;
  Log.logXmpp = false;
  HttpUtil().initialize(
    deleteTokenFromLocal: deleteToken,
    getTokenFromLocal: () async {
      final token = await getToken();
      return token;
    },
    onSocketError: () => ApiResponse(
      500,
      false,
      {'resultMsg': StringConstants.noInternetConnection},
      StringConstants.noInternetConnection,
    ),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (_) => SplashCubit(
            locator<ISplashRepository>(),
            locator<LoginRepository>(),
          ),
        ),
        BlocProvider<PreviousLoginActivityCubit>(
          create: (_) => PreviousLoginActivityCubit(locator<LoginRepository>()),
        ),
        BlocProvider(
          create: (_) => ReportUserCubit()..getReportReasons(),
        ),
        BlocProvider<LoginCubit>(
          create: (_) => LoginCubit(locator<LoginRepository>()),
        ),
        BlocProvider<ConflictLoginBloc>(
          create: (_) => ConflictLoginBloc(),
        ),
        BlocProvider(create: (_) => FriendsBloc(locator<IFriendsRepository>())),
        BlocProvider(
          create: (_) => WalletCubit(locator<IWalletRepository>()),
        ),
        BlocProvider(
          create: (_) => EnvelopTransferCubit(
            locator<IEnvelopTransferRepository>(),
            locator<LoginRepository>(),
          ),
        ),
        BlocProvider(
          create: (_) => TransferCubit(
            locator<ITransferRepository>(),
            locator<LoginRepository>(),
          ),
        ),
        BlocProvider<CountryCubit>(
          create: (context) => CountryCubit()..init(),
        ),
        BlocProvider(
          create: (_) => SfCubit(),
        ),
        BlocProvider(
          create: (_) => LogoutCubit(),
        ),
        BlocProvider(
          create: (_) =>
              PaymentCenterCubit(locator<IPaymentCenterRepository>()),
        ),
        BlocProvider(
          create: (_) => EnvelopeCubit(locator<IEnvelopeRepository>()),
        ),
        BlocProvider(
          create: (_) => ChatOtherCubit(),
        ),
        BlocProvider<PickFileCubit>(
          create: (_) => PickFileCubit(),
        ),
        BlocProvider(
          create: (_) => DownloadCubit()..init(),
        ),
        BlocProvider(
          create: (_) => GroupMangeBloc(),
        ),
      ],
      child: MyApp(version: version, buildNumber: buildNumber),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? securityContext) {
    return super.createHttpClient(securityContext)
      ..connectionTimeout = Duration(seconds: 30)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
