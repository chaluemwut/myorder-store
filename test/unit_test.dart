import 'package:flutter_test/flutter_test.dart';
import 'package:istore/beans/cart_bean.dart';
import 'package:istore/mock_api.dart';
import 'package:istore/system/system_instance.dart';

void main() {
  group('unit-test', () {
    test('Test data mock', () {
      MockAPI mockAPI = MockAPI();
      var categoryList = mockAPI.getCategories();

      expect(categoryList.length, 5);

      var firstCategory = categoryList[0];
      expect(firstCategory.id, 1);
      expect(firstCategory.title, "เสื้อผ้า");

      var productList = mockAPI.getProducts(firstCategory);
      expect(productList.length, 5);
      expect(productList[0].id, 1);
      expect(productList[0].price, 100);
      expect(productList[0].name, 'เสื้อแขนยาว');
    });

    test('Test add card', () {
      expect(SystemInstance().cartBeans.length, 0);
      SystemInstance().cartBeans.add(CartBean(1, '', 100, 1, ''));
      expect(SystemInstance().cartBeans.length, 1);

      SystemInstance().cartBeans.clear();
      expect(SystemInstance().cartBeans.length, 0);
    });
  });
}
