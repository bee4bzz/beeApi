import 'package:air_quality_repository/air_quality_repository.dart';
import 'package:authentication_repository/authentication_repository.dart'
    hide AuthenticationState;
import 'package:bluetooth_repository/bluetooth_repository.dart';
import 'package:consumption_repository/consumption_repository.dart';
import 'package:element_api/element_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fogo_smart_home/authentication/authentication.dart';
import 'package:flutter_fogo_smart_home/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_fogo_smart_home/utils/helpers.dart';
import 'package:flutter_fogo_smart_home/utils/keys.dart';
import 'package:geolocation_repository/geolocation_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:element_repository/element_repository.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Provides repositories and the authentication bloc to the app.
class App extends StatelessWidget {
  const App({
    super.key,
    required this.authenticationRepository,
    required this.userRepository,
    required this.homeRepository,
    required this.spaceRepository,
    required this.deviceRepository,
    required this.bluetoothRepository,
    required this.geolocationRepository,
    required this.airQualityRepository,
    required this.weatherRepository,
    required this.calendarRepository,
    required this.consumptionRepository,
    required this.deviceSensorDataRepository,
    required this.appRoute,
    required this.signRoute,
    required this.splashRoute,
  });

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final ElementRepository<Home> homeRepository;
  final ElementRepository<Space> spaceRepository;
  final ElementRepository<Device> deviceRepository;
  final BluetoothRepository bluetoothRepository;
  final GeolocationRepository geolocationRepository;
  final AirQualityRepository airQualityRepository;
  final WeatherRepository weatherRepository;
  final ElementRepository<Calendar> calendarRepository;
  final ConsumptionRepository consumptionRepository;
  final ElementRepository<DeviceSensorData> deviceSensorDataRepository;
  final Route<void> appRoute;
  final Route<void> signRoute;
  final Route<void> splashRoute;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(create: (_) {
          return authenticationRepository;
        }),
        RepositoryProvider<UserRepository>(create: (_) {
          return userRepository;
        }),
        RepositoryProvider<ElementRepository<Home>>(create: (_) {
          return homeRepository;
        }),
        RepositoryProvider<ElementRepository<Space>>(create: (_) {
          return spaceRepository;
        }),
        RepositoryProvider<ElementRepository<Device>>(create: (_) {
          return deviceRepository;
        }),
        RepositoryProvider<ElementRepository<Calendar>>(create: (_) {
          return calendarRepository;
        }),
        RepositoryProvider<BluetoothRepository>(
          create: (_) {
            return bluetoothRepository;
          },
          lazy: false,
        ),
        RepositoryProvider<GeolocationRepository>(create: (_) {
          return geolocationRepository;
        }),
        RepositoryProvider<AirQualityRepository>(create: (_) {
          return airQualityRepository;
        }),
        RepositoryProvider<WeatherRepository>(create: (_) {
          return weatherRepository;
        }),
        RepositoryProvider<ConsumptionRepository>(create: (_) {
          return consumptionRepository;
        }),
      ],
      // Only authentication bloc is provided because we don't need the others at this point.
      child: BlocProvider<AuthenticationBloc>(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        )
          ..add(const AuthenticationSubscriptionRequested())
          ..add(const AuthenticationSessionRequested()),
        child: RootApp(
            appRoute: appRoute,
            signRoute: signRoute,
            splashRoute: splashRoute,
            key: Keys.rootPageKey),
      ),
    );
  }
}

/// Init the MaterialApp and the BlocListener to listen to the authentication state.
class RootApp extends StatefulWidget {
  const RootApp(
      {required this.appRoute,
      required this.signRoute,
      required this.splashRoute,
      super.key});

  final Route<void> appRoute;
  final Route<void> signRoute;
  final Route<void> splashRoute;

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      title: '${Strings.appName} ${FlavorConfig.instance.name}',
      darkTheme: FogoThemes.darkTheme,
      themeMode: ThemeMode.dark,
      builder: (_, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listenWhen: (previous, current) {
            /// This is to avoid rebuilding the app when the user is
            /// going to authenticating state to the unauthenticated state
            /// or unauthenticating to authenticated.
            /// Avoid deleting the user mail and pwd from the sign in page.
            /// or rebuilding the app when failing to disconnect.
            var prev1 = previous.status != AuthenticationStatus.authenticating;
            var curr1 = current.status != AuthenticationStatus.unauthenticated;
            var prev2 =
                previous.status != AuthenticationStatus.unauthenticating;
            var curr2 = current.status != AuthenticationStatus.authenticated;

            return reject2False(prev1, curr1) && reject2False(prev2, curr2);
          },
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  widget.appRoute,
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  widget.signRoute,
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => widget.splashRoute,
    );
  }
}
