class Category {
  final String name;
  final String route;
  final String icon;
  Category(this.name, this.route, this.icon);

  @override
  String toString() {
    return 'Category{name: $name, route: $route}';
  }
}
