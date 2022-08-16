enum RestaurantStatus {
  open,
  closed;

  @override
  String toString() {
    if (this == RestaurantStatus.open) return "Open Now";
    if (this == RestaurantStatus.closed) return "Closed";
    return "N/A";
  }
}
