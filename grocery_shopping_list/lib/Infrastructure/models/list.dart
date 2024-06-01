class GroceryList {
  final String id;
  final String date;
  final String content;

  GroceryList({required this.id, required this.date, required this.content});

  factory GroceryList.fromJson(Map<String, dynamic> json) {
    return GroceryList(
      id: json['_id'],
      date: json['date'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'content': content,
    };
  }
}