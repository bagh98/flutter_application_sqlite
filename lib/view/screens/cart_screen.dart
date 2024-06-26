import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';

import '../../constants/global_consts.dart';
import '../../controller/app_controller.dart';
import '../../models/meal_model.dart';
import '../../view/widgets/app_widgets/myappbar_widget.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final Future<PaymentConfiguration> _googlePayConfigFuture;
  List<PaymentItem> _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];

  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture = PaymentConfiguration.fromAsset('pay.json');
  }

  getItemTotal(List<MealModel> items) {
    double sum = 0.0;
    items.forEach((e) {
      sum += e.price;
    });
    return "\$$sum";
  }

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    return Scaffold(
      backgroundColor: scafoldcolor,
      appBar: MyAppBar(context, controller, false, true, "Cart"),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: GetBuilder<AppController>(
                builder: (_) {
                  if (controller.cartmeals.length == 0) {
                    return Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Center(
                        child: Text(
                          "No items found",
                          style: blackindiestyle,
                        ),
                      ),
                    );
                  }
                  return ListView(
                    shrinkWrap: true,
                    children: controller.cartmeals
                        .map((d) => generateCart(context, d))
                        .toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.grey.shade200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(child: GetBuilder<AppController>(
              builder: (_) {
                return RichText(
                  text: TextSpan(
                      text: "Total  ",
                      style: blackstyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: getItemTotal(controller.cartmeals).toString(),
                          //style: blackstyle
                        )
                      ]),
                );
              },
            )),
            Container(
              alignment: Alignment.centerLeft,
              height: 50,
              child: FutureBuilder<PaymentConfiguration>(
                  future: _googlePayConfigFuture,
                  builder: (context, snapshot) => snapshot.hasData
                      ? GooglePayButton(
                          paymentConfiguration: snapshot.data!,
                          paymentItems: _paymentItems,
                          type: GooglePayButtonType.buy,
                          margin: const EdgeInsets.all(5.0),
                          onPaymentResult: onGooglePayResult,
                          loadingIndicator: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Container()),
            )
          ],
        ),
      ),
    );
  }

  Widget generateCart(BuildContext context, MealModel d) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
              top: BorderSide(color: Colors.grey.shade200, width: 1.0),
            )),
        height: size.width < 480 ? size.height * .18 : size.height * .3,
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              height: 150.0,
              width: 200.0,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.white24, blurRadius: 5.0)
                  ],
                  image: DecorationImage(
                      image: AssetImage(d.image),
                      fit: size.width < 480
                          ? BoxFit.fitHeight
                          : BoxFit.fitWidth)),
            ),
            Expanded(
                child: Padding(
              padding: size.width < 480
                  ? EdgeInsets.only(top: 30.0, left: 15.0)
                  : EdgeInsets.only(top: 30.0, left: 100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          d.name,
                          style: blackstyle,
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: InkResponse(
                          onTap: () {
                            Get.find<AppController>()
                                .removeFromCart(d.shopId ?? 0);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Item removed from cart successfully")));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("Price ${d.price.toString()}"),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
