import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jeet_ke_jeo/src/config/constants/colors.dart';
import 'package:jeet_ke_jeo/src/models/user.model.dart';
import 'package:jeet_ke_jeo/src/services/firebase/auth.dart';
import 'package:jeet_ke_jeo/src/services/firebase/collections/user.collection.dart';
import 'package:velocity_x/velocity_x.dart';

class PurchaseLottery extends StatefulWidget {
  final dynamic lotteryData;

  const PurchaseLottery({super.key, required this.lotteryData});

  @override
  State<PurchaseLottery> createState() => _PurchaseLotteryState();
}

class _PurchaseLotteryState extends State<PurchaseLottery> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseUserCollection _collection = FirebaseUserCollection();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late String uid;
  bool _loaded = false;

  final String initialCountry = 'PK';
  final PhoneNumber number = PhoneNumber(isoCode: 'PK');

  @override
  void initState() {
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

    var userModel = UserModel(
        uid: uid,
        username: username,
        address: address,
        phone: phone,
        lotteryPurchased: [lotteryNumber]);
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
      body: [
        Opacity(
            opacity: _loaded ? 0.5 : 1,
            child: AbsorbPointer(absorbing: _loaded, child: _body())),
        Opacity(
            opacity: _loaded ? 1 : 0,
            child: const Center(
                child: CircularProgressIndicator(
              color: AppColors.blackColor,
            )))
      ].stack(),
    );
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
      ),
      const SizedBox(height: 20),
      InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          print(number.phoneNumber);
        },
        onInputValidated: (bool value) {
          print(value);
        },
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        selectorTextStyle: const TextStyle(color: Colors.black),
        initialValue: number,
        textFieldController: _phoneController,
        formatInput: true,
        keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true),
        inputBorder: const OutlineInputBorder(),
        onSaved: (PhoneNumber number) {
          print('On Saved: $number');
        },
      ).box.white.rounded.make().p4(),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: saveUserInformation,
        child: [
          "Purchase".text.xl4.make(),
          const Icon(Icons.arrow_forward),
        ].row(alignment: MainAxisAlignment.center).wFull(context),
      )
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
}
