import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/views/category/item_details.dart';

class AboutShop extends StatefulWidget {
  final String vendorId;
  final String userId;
  final String data;

  const AboutShop({super.key, required this.vendorId, required this.userId, required this.data});

  @override
  _AboutShopState createState() => _AboutShopState();
}

class _AboutShopState extends State<AboutShop> {
  late Stream<QuerySnapshot> vendorsStream;
  late DocumentSnapshot vendorData;

  @override
  void initState() {
    super.initState();
    vendorsStream = getVendors();
    fetchVendorData();
  }

  // Function to fetch vendor data from Firestore
  void fetchVendorData() async {
    var snapshot = await FirebaseFirestore.instance
        .collection(vendorcollection)
        .doc(widget.vendorId)
        .get();

    setState(() {
      vendorData = snapshot;
    });
  }

  // Function to get vendors stream
  static Stream<QuerySnapshot> getVendors() {
    return FirebaseFirestore.instance.collection(vendorcollection).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFDAD3BE),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'About Shop',
          style: TextStyle(color: Colors.black, fontFamily: 'semibold'),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vendor Information Section
            Container(
              width: double.infinity, // Expand container to full width
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFF6E6CB),

                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: FutureBuilder(
                future: vendorsStream.first,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No vendors found'));
                  }

                  // Find the vendor with matching vendor_id
                  var vendor = snapshot.data!.docs.firstWhere(
                    (doc) => doc.id == widget.vendorId,
                  );

                  // Extract vendor information
                  String imageUrl = vendor['imageUrl'];
                  String shopEmailAddress = vendor['shop_email_address'];
                  String shopName = vendor['shop_name'];
                  String vendorName = vendor['vendor_name'];

                  // Display vendor information with stylish UI
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(imageUrl),
                            radius: 50,
                          ),
                          const SizedBox(width: 15.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Shop Name
                                Container(
                                  padding: const EdgeInsets.all(12.0),
                                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                                  decoration: BoxDecoration(
                                     color: const Color(0xFFF6E6CB),
                                    borderRadius: BorderRadius.circular(5.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Company Name:',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: Text(
                                          shopName,
                                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Vendor Name
                                Container(
                                  padding: const EdgeInsets.all(12.0),
                                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF6E6CB),
                                    borderRadius: BorderRadius.circular(5.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Agents Name:',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: Text(
                                          vendorName,
                                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Email
                                Container(
                                  padding: const EdgeInsets.all(12.0),
                                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                                  decoration: BoxDecoration(
                                     color: const Color(0xFFF6E6CB),
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Email:',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: Text(
                                          shopEmailAddress,
                                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 16.0),
                      const Text(
                        
                        'Other Jobs',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 16.0),

            // Jobs Section
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(productsCollection)
                    .where('vendor_id', isEqualTo: widget.vendorId)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No products found'));
                  }

                  var products = snapshot.data!.docs;

                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      var product = products[index];
                      String imageUrl = product['p_imgs'][0];
                      String pPrice = product['p_price'];
                      String? pdPrice = product['pd_price'];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemDetails(
                                title: product['p_name'],
                                data: product,
                                userId: widget.userId,
                                showIcon: false,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                                child: Image.network(
                                  imageUrl,
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['p_name'],
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        // Display pPrice with strikethrough if pdPrice exists
                                        if (pdPrice != null && pdPrice.isNotEmpty) ...[
                                          Text(
                                            'Rs. $pPrice',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.orange,
                                              decoration: TextDecoration.lineThrough,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(width: 8.0),
                                          Text(
                                            'Rs. $pdPrice',
                                            style: const TextStyle(fontSize: 16, color: Colors.orange),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ] else
                                          // Display only pPrice if pdPrice is not available
                                          Text(
                                            'Rs. $pPrice',
                                            style: const TextStyle(fontSize: 16, color: Colors.orange),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
