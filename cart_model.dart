//Kani nga code pud sir is, basically mao ang “cart manager” sa app — si CartModel ang bahala sa tanan sa imong shopping cart; siya mag-handle sa pag-add ug items (addItem), pag-remove (removeItem), pag-compute sa total price (totalPrice), ug pag-clear sa tanan (clearCart), unya every time naay changes, mo-notifyListeners() siya para ma-refresh dayon ang UI — like real-time updates.
import 'package:flutter/foundation.dart';

class CartModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;


  void addItem(Map<String, dynamic> item) {
    // Check if item already exists in the cart
    int existingIndex = _items.indexWhere((i) => i['name'] == item['name']);
    if (existingIndex != -1) {
      _items[existingIndex]['quantity'] += item['quantity'];
    } else {
      _items.add(Map<String, dynamic>.from(item));
    }
    notifyListeners();
  }


  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  double get totalPrice {
    return _items.fold(
      0.0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
  }


  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
