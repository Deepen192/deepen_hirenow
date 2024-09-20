import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/views/orders_screen/components/order_place_details.dart';
import 'package:flutter_application_1/views/orders_screen/components/order_status.dart';
import 'package:flutter_application_1/views/orders_screen/components/pdf_viewer.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({Key? key,  this.data});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
    backgroundColor: const Color(0xFFDAD3BE),     
    iconTheme: const IconThemeData(color: Colors.white),   
        title:"Order Details".text.fontFamily(semibold).color(Colors.black).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                color: Colors.green,icon: Icons.done,title: "Placed",showDone:data['order_placed']),
                orderStatus(color: Colors.blue,icon: Icons.thumb_up,title: "Processing",showDone:data['order_confirmed']),
                  orderStatus(color: Colors.orange,icon: Icons.car_crash,title: "Reviewed",showDone:data['order_on_delivery']),
                   orderStatus(color: Colors.green,icon: Icons.done_all_rounded,title: "Selection",showDone:data['order_delivered']),

                  const Divider(),
                  10.heightBox,
                  "Ordered Product".text.size(16).color(darkFontGrey).fontFamily(semibold).makeCentered(),
                  10.heightBox,
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(data['orders'].length, (index){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
			                Align(
                       alignment: Alignment.center, // Align the image within the available space
                       child: Image.network(
                        data['orders'][index]['img'],
                        width: 300,
                        height: 300,
                        fit: BoxFit.fitWidth,
                       ),
                      ),
                          orderPlaceDetails(
                            title1: data['orders'][index]['title'],
                            title2:"Rs.${data['orders'][index]['tprice']}",
                            d1: "Proffesion",
                            d2: "Salary"
                          ),
                          
                          
              
                   const Divider(),
                   10.heightBox,
        
                  Column(
                    children: [
                       orderPlaceDetails(
                    d1: data['order_code'],
                    d2:ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PdfViewerScreen(pdfUrl:data['file_url']),
                          ),
                        );
                      },
                      child: Text("Open Doc", style: TextStyle(color: Colors.orange)),
                    ),
                    title1: "Order Code",
                    title2: "CV Doc",
                   ),
        
                    orderPlaceDetails(
                    d1: intl.DateFormat().add_yMd().format((data['order_date'].toDate())) ,
                    d2:data['payment_method'],
                    title1: "Order Date",
                    title2: "Payment Method",
                   ), 
        
                    orderPlaceDetails(
                    d1: data?['payment_status'] == false ? "Unpaid" : "Paid",
                    d2: "Order Placed",
                    title1: "Payment Status",
                    title2: "Delivery Status",
                   ),

        
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(                    
                          crossAxisAlignment:CrossAxisAlignment.start,
                            children:[
                            "Shipping Address".text.fontFamily(semibold).make(),
                            // "${data['order_by_name']}".text.make(),
                            Row(children: [
                              "Name:${data['order_by_firstname']}".text.make(),SizedBox(width: 5,),
                            "${data['order_by_lastname']}".text.make(),
                            ],),
                             
                            "Email:${data['order_by_email']}".text.make(),
                            "Address:${data['order_by_address']}".text.make(),                           
                            "Phone:${data['order_by_phone']}".text.make(),
                            // "${data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                      ),
        
                      SizedBox(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            " Total Amount".text.fontFamily(semibold).make(),
                            "Rs.${data['total_amount']}".text.color(Colors.orange).fontFamily(bold).make(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                    ],
                  ).box.outerShadowMd.white.make(),
        
              
                          const Divider(),
                        ],
                      );
                    }).toList(),
                  ).box.outerShadowMd.white.margin(const EdgeInsets.only(bottom: 4)).make(),
                  20.heightBox,

            ],
              
          ),
        ),
      ),
    );
  }
}