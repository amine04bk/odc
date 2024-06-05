
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spacexview/screens/data.dart';
 
class Home extends StatefulWidget {
 
  @override
  _HomeState createState() => _HomeState();
}
 
class _HomeState extends State<Home> {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = true;
 
  @override
  void initState() {
    super.initState();
    _getData();
  }
 
  DataModel? dataFromAPI;
  _getData() async {
    try {
      String url = "https://dummyjson.com/products";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        dataFromAPI = DataModel.fromJson(json.decode(res.body));
        _isLoading = false;
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
 
/* Widget build goes after this */

  /* Widget build goes after this */
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("REST API Example"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        dataFromAPI!.products[index].thumbnail,
                        width: 100,
                      ),
                      Text(dataFromAPI!.products[index].title.toString()),
                      Text("\$${dataFromAPI!.products[index].price.toString()}"),
                    ],
                  ),
                );
              },
              itemCount: dataFromAPI!.products.length,
            ),
    );
  }

}