import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final box = GetStorage();

    List orders = box.read("orders") ?? [];

    return Scaffold(

      appBar: AppBar(
        title: const Text("My Paid CVs"),
        backgroundColor: Colors.blue,
      ),

      body: orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [

                  Icon(Icons.shopping_bag_outlined,
                      size: 80,
                      color: Colors.grey),

                  SizedBox(height: 10),

                  Text(
                    "No Orders Yet",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),

                ],
              ),
            )

          :

      ListView.builder(

        itemCount: orders.length,

        itemBuilder: (context,index){

          var order=orders[index];

          return Container(

            margin: const EdgeInsets.all(12),

            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 6,
                      color: Colors.black12)
                ]),

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                /// IMAGE
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15)),

                  child: Image.network(
                    order["image"],
                    height:180,
                    width:double.infinity,
                    fit:BoxFit.cover,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12),

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      /// NAME
                      Text(
                        order["name"],
                        style: const TextStyle(
                            fontSize:18,
                            fontWeight:FontWeight.bold),
                      ),

                      const SizedBox(height:5),

                      /// TRX
                      Text(
                        "TRX ID : ${order["trx"]}",
                        style: const TextStyle(
                            fontSize:14),
                      ),

                      const SizedBox(height:10),

                      /// STATUS
                      Row(

                        children: [

                          const Text(
                            "Status : ",
                            style: TextStyle(
                                fontWeight:
                                FontWeight.bold),
                          ),

                          Container(

                            padding:
                            const EdgeInsets.symmetric(
                                horizontal:12,
                                vertical:6),

                            decoration: BoxDecoration(

                                color: order["status"]
                                ==
                                "Pending"
                                    ? Colors.orange
                                    : Colors.green,

                                borderRadius:
                                BorderRadius.circular(8)
                            ),

                            child: Text(

                              order["status"],

                              style: const TextStyle(
                                  color:Colors.white,
                                  fontWeight:
                                  FontWeight.bold),

                            ),

                          )

                        ],

                      )

                    ],

                  ),
                )

              ],

            ),

          );

        },

      ),

    );
  }
}