import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

class AppBlocObserver extends BlocObserver {
  final Logger logger;

  const AppBlocObserver(
    this.logger,
  );

  @override
  void onEvent(Bloc bloc, Object? event) {
    logger.info(event);
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    logger.warning("bloc $bloc error", error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
