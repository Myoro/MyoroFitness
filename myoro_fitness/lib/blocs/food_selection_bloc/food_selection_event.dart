abstract class FoodSelectionEvent {
  const FoodSelectionEvent();
}

class SetFoodsEvent extends FoodSelectionEvent {
  final String query;
  const SetFoodsEvent(this.query);
}
