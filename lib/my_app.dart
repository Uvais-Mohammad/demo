import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf_chat_im/features/splash/screens/splash_screen.dart';
import 'package:sf_chat_im/shared/themes/light_colors.dart';
import 'package:sf_chat_im/shared/themes/text_styles.dart';
import 'package:sf_chat_im/shared/utilities/flavors.dart';
import 'package:sf_chat_im/shared/utilities/route_generator.dart';
import 'package:sf_chat_im/shared/widgets/flavor_banner.dart';
import 'package:sf_chat_im/shared/widgets/keyboard_dismissible.dart';
import 'package:walletconnect_modal_flutter/walletconnect_modal_flutter.dart';

final navigationKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({required this.version, super.key, this.buildNumber});
  final String version;
  final String? buildNumber;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WalletConnectModalTheme(
      data: WalletConnectModalThemeData.darkMode,
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child) => FlavorBanner(
          version: widget.version,
          buildNumber: widget.buildNumber,
          show: F.isDev,
          child: KeyboardDismissible(
            child: MaterialApp(
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('zh', 'CN'),
              ],
              locale: const Locale('zh', 'CN'),
              navigatorKey: navigationKey,
              debugShowCheckedModeBanner: false,
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(1),
                ),
                child: child!,
              ),
              title: F.title,
              theme: AppTheme.lightTheme,
              home: const SplashScreen(),
              onGenerateRoute: RouteGenerator.instance.generateRoute,
            ),
          ),
        ),
      ),
    );
  }
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    splashColor: LightColors.primary.withOpacity(0.1),
    highlightColor: LightColors.primary.withOpacity(0.05),
    colorScheme: const ColorScheme.light().copyWith(
        primary: LightColors.primary,
        secondary: LightColors.secondary,
        outline: LightColors.outline,
        outlineVariant: LightColors.outlineVariant,
        tertiary: LightColors.tertiary,
        inversePrimary: LightColors.green,
        onSecondaryContainer: LightColors.lightYellow,
        onTertiaryContainer: LightColors.lightBlue,
        secondaryContainer: LightColors.blackBackground,
        surface: LightColors.fill,
        surfaceVariant: LightColors.fillVariant,
        surfaceTint: LightColors.fillVariant2,
        tertiaryContainer: LightColors.fillBlackVariant,
        onTertiary: LightColors.fillBlackVariant2,
        error: LightColors.error,
        shadow: LightColors.primary),
    primaryColor: LightColors.primary,
    appBarTheme: AppBarTheme(
      backgroundColor: LightColors.tertiary,
      elevation: 0,
      titleTextStyle: TextStyles.titleMedium,
      iconTheme: const IconThemeData(
        color: LightColors.secondary,
      ),
      centerTitle: false,
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(),
    // scaffoldBackgroundColor: LightColors.tertiary,
    textTheme: TextTheme(
      titleLarge: TextStyles.titleLarge,
      titleMedium: TextStyles.titleMedium,
      titleSmall: TextStyles.titleSmall,
      bodyLarge: TextStyles.bodyLarge,
      bodyMedium: TextStyles.hint,
      bodySmall: TextStyles.bodySmall,
      labelLarge: TextStyles.buttonWhite,
      labelMedium: TextStyles.greyText,
      labelSmall: TextStyles.textfieldText,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: LightColors.tertiary,
      textStyle: TextStyles.textfieldText,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyles.textfieldText,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyles.hint,
        suffixIconColor: LightColors.outlineVariant,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: LightColors.outline),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: LightColors.outline),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: LightColors.outline),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: LightColors.error),
        ),
        fillColor: LightColors.fill,
      ),
      menuStyle: MenuStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
        ),
        maximumSize: MaterialStateProperty.all(
          Size(
            300.w,
            300.h,
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: LightColors.outline,
            width: 1.w,
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.hint,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 13.w,
        vertical: 13.h,
      ),
      suffixIconColor: LightColors.outlineVariant,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: LightColors.outline),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: LightColors.outline),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: LightColors.outline),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: LightColors.error),
      ),
      fillColor: LightColors.fill,
    ),
    iconTheme: const IconThemeData(
      color: LightColors.outlineVariant,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(LightColors.primary),
      checkColor: MaterialStateProperty.all(LightColors.tertiary),
      overlayColor: MaterialStateProperty.all(LightColors.primary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.r),
      ),
    ),
    dividerColor: LightColors.divider,
    dividerTheme: const DividerThemeData(
      color: LightColors.divider,
      thickness: 1,
      space: 0,
      indent: 0,
      endIndent: 0,
    ),
    listTileTheme: const ListTileThemeData(
      minLeadingWidth: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: LightColors.primary,
      foregroundColor: LightColors.tertiary,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
  );
}
