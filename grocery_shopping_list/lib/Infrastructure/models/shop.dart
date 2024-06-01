class Shop {
  final String? id;
  final String ?name;
  final List<String>? items;
 

  Shop({required this.id, required this.name, required this.items, });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['_id'],
      name: json['name'],
      items: (json['items'] as String).split(', '),
      
  );
  }

  Shop copyWith({
    String? id,
    String? name,
    List<String>? items,
    
    
  }) {
    return Shop(
      id: id ?? this.id,
      name: name ?? this.name,
      items: items ?? this.items,
     
    );
  }
}