class Item {
  final String name;
  final double price;

  Item({required this.name, required this.price});
}

class AppState {
  final List<Item> items;

  AppState({required this.items});

  AppState.initialState() : items = [];
}
