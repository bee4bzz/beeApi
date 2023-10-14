import 'dart:io';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  var app = makeApp();
  runApp(app);
}

makeApp() async {
  FlavorConfig(
      name: LocalFlavor.localFlavorName,
      color: FogoColors.fogoRed,
      location: BannerLocation.bottomStart,
      variables: LocalFlavor.localFlavorVariables);

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: FogoColors.fogoBlack));
  }

  // BOX
  final path = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(path.path);

  final calendarBox =
      await Hive.openBox<String>(LocalFlavor.hiveBoxCalendarName);
  final userBox = await Hive.openBox<String>(LocalFlavor.hiveBoxUserName);
  final authBox = await Hive.openBox<String>(LocalFlavor.hiveBoxAuthName);
  final homeBox = await Hive.openBox<String>(LocalFlavor.hiveBoxHomeName);
  final spaceBox = await Hive.openBox<String>(LocalFlavor.hiveBoxSpaceName);
  final deviceBox = await Hive.openBox<String>(LocalFlavor.hiveBoxDeviceName);
  final consumptionBox =
      await Hive.openBox<String>(LocalFlavor.hiveBoxConsumptionName);
  final bleBox = await Hive.openBox<String>(LocalFlavor.hiveBoxBle);
  final sensorDataBox =
      await Hive.openBox<String>(LocalFlavor.hiveBoxSensorDataName);

  // API
  final authApi = LocalJwtAuthenticationApi(userBox, authBox);
  final geolocationApi = GeolocationOpenApi();
  final List<AirQualityApi> airQualityApis =
      List.from([const AirQualityOpenApi()]);
  final List<MeteoOpenWeatherApi> weatherApis = List.from([
    MeteoFranceWeatherApi(),
    MeteoForecastWeatherApi(),
    MeteoGemWeatherApi(),
    MeteoGfsWeatherApi(),
  ]);
  final localUserApi = LocalUserApi(userBox);
  final localDeviceApi = LocalElementApi(
    box: deviceBox,
    fromJson: Device.fromJson,
  );
  final localSpaceApi = LocalElementApi(
    box: spaceBox,
    fromJson: Space.fromJson,
  );
  final localHomeApi = LocalElementApi(
    box: homeBox,
    fromJson: Home.fromJson,
  );
  final localSensorApi = LocalElementApi(
    box: sensorDataBox,
    fromJson: DeviceSensorData.fromJson,
  );

  final flutterReactiveBle = FlutterReactiveBle();

  return App(
    /// make box to api like user repo
    authenticationApi: authApi,
    userApi: localUserApi,
    homeApi: localHomeApi,
    spaceApi: localSpaceApi,
    calendarApi: LocalElementApi(
      box: calendarBox,
      fromJson: Calendar.fromJson,
    ),
    deviceApi: localDeviceApi,
    bluetoothApi: BluetoothRepository(
      flutterReactiveBle,
      BluetoothPreferences(bleBox),
    ),
    geolocationApi: GeolocationRepository(geolocationApi),
    airQualityApi: AirQualityRepository(airQualityApis),
    weatherApi: WeatherRepository(weatherApis),
    consumptionApi: ConsumptionRepository(
        consumptionApi: ConsumptionLocalStorageApi(
      box: consumptionBox,
    )),
    deviceSensorDataApi:
        ElementRepository<DeviceSensorData>(elementApi: localSensorApi),
    appRoute: AppPage.route(),
    signRoute: SignPage.route(),
    splashRoute: SplashPage.route(),
  );
}
