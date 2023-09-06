import 'package:flutter/material.dart';
import 'package:istore/data.dart';
import 'package:istore/mock_api.dart';
import 'package:istore/product_list.dart';
import 'package:istore/system/system_instance.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State {
  List<Category> _apiMocking = MockAPI().getCategories();
  String username = "";

  @override
  void initState() {
    SharedPreferences.getInstance().then((ins) {
      username = ins.getString("user")!;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(children: [
        Padding(
            padding: EdgeInsets.only(top: 15, bottom: 5, left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Category'),
                if (username != "") Text("Hi, ${username}"),
                IconButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Cart())),
                  // icon: Icon(Icons.shopping_cart)
                  icon: Stack(
                    children: <Widget>[
                      Icon(Icons.shopping_cart),
                      if (SystemInstance().cartBeans.length > 0)
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 15,
                              minHeight: 15,
                            ),
                            child: Text(
                              "${SystemInstance().cartBeans.length}",
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                    ],
                  ),
                )
              ],
            )),
        ...List.generate(_apiMocking.length, (index) {
          Category category = _apiMocking[index];
          Card c = Card(
            key: Key("${category.id}"),
            child: Column(
              children: [
                SizedBox(
                  // height: 100,
                  child: FadeInImage.assetNetwork(
                      placeholder: "assets/loading.gif",
                      fit: BoxFit.cover,
                      image: category.imgURL),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text("${category.title}"))
              ],
            ),
          );
          return InkWell(
            child: c,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    ProductList(groupId: category.id))),
          );
        })
      ]),
    ));
  }
}
