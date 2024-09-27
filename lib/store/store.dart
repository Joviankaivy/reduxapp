import 'package:redux/redux.dart';
import '../models/app_state.dart';
import '../reducers/item_reducer.dart';

Store<AppState> createStore() {
  return Store<AppState>(
    itemReducer,
    initialState: AppState.initialState(),
  );
}
