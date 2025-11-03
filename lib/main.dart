import 'package:equity/app.dart';
import 'package:equity/compte_details/data/compte_details_repository.dart';
import 'package:equity/compte_details/redux/compte_details_redux.dart';
import 'package:equity/home/data/home_repository.dart';
import 'package:equity/home/redux/home_redux.dart';
import 'package:equity/redux/app_middlewares.dart';
import 'package:equity/redux/app_reducers.dart';
import 'package:equity/redux/app_state.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  await dotenv.load(fileName: '.env');
  final store = Store<AppState>(
    appReducers,
    middleware: createAppMiddlewares(
      homeRepository: HomeRepository(),
      compteDetailsRepository: CompteDetailsRepository(),
    ),
    initialState: AppState(
      homeState: HomeState(),
      comptesDetailsState: ComptesDetailsState(),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App(store));
}
