class OrderPlaceRequest {
  List<LineItems> ?lineItems;

  OrderPlaceRequest({lineItems});

  OrderPlaceRequest.fromJson(Map<String, dynamic> json) {
    if (json['line_items'] != null) {
      lineItems =  <LineItems>[];
      json['line_items'].forEach((v) {
        lineItems?.add(new LineItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (lineItems != null) {
      data['line_items'] = lineItems?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LineItems {
  int? productId;
  int? quantity;


  LineItems({productId, quantity, variationId});

  LineItems.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}