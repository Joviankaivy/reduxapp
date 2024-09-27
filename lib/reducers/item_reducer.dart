import '../models/app_state.dart';
import '../actions/item_actions.dart';

AppState itemReducer(AppState state, dynamic action) {
  if (action is AddItemAction) {
    return AppState(
      items: List.from(state.items)..add(Item(name: action.name, price: action.price)),
    );
  } else if (action is UpdateItemAction) {
    List<Item> updatedItems = List.from(state.items);
    updatedItems[action.index] = Item(name: action.newName, price: action.newPrice);
    return AppState(items: updatedItems);
  } else if (action is DeleteItemAction) {
    List<Item> updatedItems = List.from(state.items)..removeAt(action.index);
    return AppState(items: updatedItems);
  }
  return state;
}
