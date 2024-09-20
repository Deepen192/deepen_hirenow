import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ApplyJobScreen extends StatefulWidget {
  const ApplyJobScreen({Key? key}) : super(key: key);

  @override
  State<ApplyJobScreen> createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen> {
  int selectedValue = 0;
  PlatformFile? _selectedFile;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFile = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              "Apply Now",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Cover Letter",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                        maxLength: 800,
                        maxLines: 7,
                        decoration: textFormDecoration.copyWith(
                            //     labelText: 'Personalized message',
                            )),
                  ),
                  const Text(
                    "Upload CV",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _pickFile,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _selectedFile == null
                          ? const Text(
                              "Click to upload your CV (PDF only)",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    _selectedFile!.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green[700],
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RadioListTile(
                            value: 1,
                            groupValue: selectedValue,
                            onChanged: (int? value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                            title: Row(
                              children: [
                                Icon(
                                  Icons.payment_rounded,
                                  color: selectedValue == 1
                                      ? const Color(0xFF0095FF)
                                      : Colors.grey,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Pay via e-Sewa',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: selectedValue == 1
                                        ? const Color(0xFF0095FF)
                                        : Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            activeColor: const Color(0xFF0095FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            tileColor: selectedValue == 1
                                ? Colors.blue.withOpacity(0.070)
                                : null,
                          ),
                          RadioListTile(
                            value: 2,
                            groupValue: selectedValue,
                            onChanged: (int? value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                            title: Row(
                              children: [
                                Icon(
                                  Icons.payment_rounded,
                                  color: selectedValue == 2
                                      ? const Color(0xFF0095FF)
                                      : Colors.grey,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Pay via Khalti',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: selectedValue == 2
                                        ? const Color(0xFF0095FF)
                                        : Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            activeColor: const Color(0xFF0095FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            tileColor: selectedValue == 2
                                ? Colors.blue.withOpacity(0.070)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Card(
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Rs. 25',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Color(0xFFff5f1f),
                            thickness: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: BottomSheet(
            backgroundColor: const Color(0xFFFFFFFF),
            onClosing: () {},
            builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  if (selectedValue == 1) {
                    // ignore: avoid_print
                    print('e-Sewa');
                  } else if (selectedValue == 2) {
                    // ignore: avoid_print
                    print('khalti');
                  }
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: const BorderSide(
                        color: Color(0xFF0095FF),
                        width: 3.0,
                      ),
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all(
                    const Color(0xFF0095FF),
                  ),
                  shadowColor: WidgetStateProperty.all(
                    Colors.black.withOpacity(0.25),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.payment_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Confirm Payment & Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: '',
  hintText: '',
  alignLabelWithHint: true,
  labelStyle: const TextStyle(color: Color(0xFF0095FF)),
  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.70)),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color(0xFF7F00FF),
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color(0xFFFF4433),
      width: 2,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  contentPadding: const EdgeInsets.only(left: 10, top: 10),
);
