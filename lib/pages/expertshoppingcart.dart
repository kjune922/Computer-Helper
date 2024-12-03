import 'package:com_recipe/Network.dart';
import 'package:com_recipe/globals.dart';
import 'package:flutter/material.dart';

class ExpertShoppingcart extends StatefulWidget {
  ExpertShoppingcart({super.key});

  @override
  State<ExpertShoppingcart> createState() => _ExpertShoppingcartState();
}

class _ExpertShoppingcartState extends State<ExpertShoppingcart> {
  List<Map<String, dynamic>> components = [];
  bool nowLoading = true;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  // 초기 데이터 가져오기
  void initializeData() async {
    final Network _userNetwork = Network("http://116.124.191.174:15011/shop");
    final List<dynamic> userData =
        await _userNetwork.productDetail(registeredUsername!);

    setState(() {
      components = userData.cast<Map<String, dynamic>>();
      nowLoading = false;
    });
  }

  // 부품 추가
  void addComponent(String name, int price) async {
    final Network _addNetwork =
        Network("http://116.124.191.174:15011/addcomponent");
    final List<dynamic> response = await _addNetwork.productDetail(name);

    if (response.isNotEmpty) {
      setState(() {
        components.add({"name": name, "price": price});
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('부품이 추가되었습니다.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('부품 추가에 실패했습니다.')),
      );
    }
  }

  // 부품 삭제
  void removeComponent(int index) async {
    final Network _removeNetwork =
        Network("http://116.124.191.174:15011/removecomponent");
    final List<dynamic> response =
        await _removeNetwork.productDetail(components[index]['name']);

    if (response.isNotEmpty) {
      setState(() {
        components.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('부품이 삭제되었습니다.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('부품 삭제에 실패했습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("숙련자용 장바구니"),
        backgroundColor: Colors.green,
      ),
      body: nowLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(labelText: "부품 이름"),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "가격"),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          if (nameController.text.isNotEmpty &&
                              priceController.text.isNotEmpty) {
                            addComponent(
                              nameController.text,
                              int.parse(priceController.text),
                            );
                            nameController.clear();
                            priceController.clear();
                          }
                        },
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: components.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(components[index]['name']),
                        subtitle: Text('${components[index]['price']}원'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => removeComponent(index),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}