import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jeet_ke_jeo/src/config/constants/colors.dart';
import 'package:jeet_ke_jeo/src/models/lottery.model.dart';
import 'package:jeet_ke_jeo/src/models/user.model.dart';
import 'package:jeet_ke_jeo/src/services/firebase/auth.dart';
import 'package:jeet_ke_jeo/src/services/firebase/collections/user.collection.dart';
import 'package:jeet_ke_jeo/src/widgets/background.dart';
import 'package:jeet_ke_jeo/src/widgets/dialogbox.widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class PurchaseLottery extends StatefulWidget {
  final dynamic lotteryData;

  const PurchaseLottery({super.key, required this.lotteryData});

  @override
  State<PurchaseLottery> createState() => _PurchaseLotteryState();
}

class _PurchaseLotteryState extends State<PurchaseLottery> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();
  final FirebaseUserCollection _collection = FirebaseUserCollection();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _datePickerController = TextEditingController();
  late String uid;
  bool _loaded = false;

  final String initialCountry = 'PK';

  @override
  void initState() {
    _datePickerController.text =
        DateFormat('dd-MM-yyyy').format(DateTime.now());
    setState(() {
      _loaded = true;
    });
    Future<User?> user = _auth.getCurrentUser();
    user.then((value) {
      uid = value!.uid;
      _collection.getUser(uid).then((value) {
        if (value != null) {
          _usernameController.text = value.username;
          _addressController.text = value.address;
          _phoneController.text = value.phone;
        }
      });
    });

    setState(() {
      _loaded = false;
    });

    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void saveUserInformation() async {
    setState(() {
      _loaded = true;
    });

    String username = _usernameController.text;
    String address = _addressController.text;
    String phone = _phoneController.text;
    String lotteryNumber = widget.lotteryData["lotteryNumber"];
    DateTime date = DateFormat('dd-MM-yyyy').parse(_datePickerController.text);
    Timestamp timestamp = Timestamp.fromDate(date);

    var userModel = UserModel(
        uid: uid,
        username: username,
        address: address,
        phone: phone,
        lotteryPurchased: [
          Lottery(lotteryNumber: lotteryNumber, lotteryBoughtOn: timestamp)
        ]);
    _collection.addUser(userModel.toJson());
    setState(() {
      _loaded = false;
    });

    if (context.mounted) {
      VxToast.show(context, msg: "User information saved successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BackGround(body: _widget),
    );
  }

  Widget _widget(){
    return [
      Opacity(
          opacity: _loaded ? 0.5 : 1,
          child: AbsorbPointer(absorbing: _loaded, child: _body())),
      Opacity(
          opacity: _loaded ? 1 : 0,
          child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.blackColor,
              )))
    ].stack();
  }

  Widget _body() {
    return [
      "Purchase Lottery"
          .text
          .color(AppColors.blackColor)
          .xl4
          .make()
          .centered()
          .box
          .rounded
          .white
          .make()
          .wFourFifth(context),
      const SizedBox(height: 20),
      "Only 500/-Rs"
          .text
          .white
          .xl6
          .textStyle(GoogleFonts.shadowsIntoLight(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ))
          .make()
          .box
          .alignCenterLeft
          .make(),
      const SizedBox(height: 20),
      _form(),
    ]
        .column()
        .scrollVertical()
        .hFull(context)
        .box
        .withDecoration(
          const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.9],
              colors: [
                Colors.black,
                AppColors.goldColor,
              ],
            ),
          ),
        )
        .padding(const EdgeInsets.fromLTRB(20, 20, 20, 0))
        .color(Colors.black87)
        .make();
  }

  Widget _form() {
    return Form(
        key: _formKey,
        child: [
          VxTextField(
            keyboardType: TextInputType.multiline,
            controller: _usernameController,
            style: const TextStyle(color: Colors.black),
            hint: "Enter Username",
            hintStyle: const TextStyle(color: Colors.black),
            fillColor: Colors.grey.shade100,
            borderRadius: 10,
            borderType: VxTextFieldBorderType.roundLine,
            prefixIcon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter valid username';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          VxTextField(
            controller: _addressController,
            maxLine: 3,
            style: const TextStyle(color: Colors.black),
            hint: "Enter Address",
            hintStyle: const TextStyle(color: Colors.black),
            fillColor: Colors.grey.shade100,
            borderRadius: 10,
            borderType: VxTextFieldBorderType.roundLine,
            prefixIcon: const Icon(
              Icons.home,
              color: Colors.black,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter valid address';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          IntlPhoneField(
            controller: _phoneController,
            decoration: const InputDecoration(labelText: 'Phone Number'),
            initialCountryCode: initialCountry,
            onChanged: (phone) {
              print(phone.completeNumber);
            },
            validator: (value) {
              if (value!.isValidNumber()) {
                return 'Please enter valid phone number';
              }
              return null;
            },
          ).p4().box.white.rounded.make().p4(),
          const SizedBox(height: 20),
          "Select Date"
              .text
              .color(AppColors.blackColor)
              .xl4
              .textStyle(GoogleFonts.shadowsIntoLight(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ))
              .make()
              .box
              .alignCenter
              .make(),
          TextField(
            controller: _datePickerController,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              fillColor: AppColors.whiteColor,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2025));
              if (picked != null) {
                String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
                setState(() {
                  _datePickerController.text = formattedDate;
                });
              }
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                saveUserInformation();
              } else {
                CustomDialog.dialog(context, "Purchase Failed",
                    _formKey.currentState!.toString());
              }
            },
            child: [
              "purchase".tr.text.xl4.make(),
              const Icon(Icons.arrow_forward),
            ].row(alignment: MainAxisAlignment.center).wFull(context),
          )
        ].column());
  }
}
