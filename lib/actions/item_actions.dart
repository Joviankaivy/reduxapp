class AddItemAction {
  final String name;
  final double price;

  AddItemAction(this.name, this.price);
}

class UpdateItemAction {
  final int index;
  final String newName;
  final double newPrice;

  UpdateItemAction(this.index, this.newName, this.newPrice);
}

class DeleteItemAction {
  final int index;
  DeleteItemAction(this.index);
}
