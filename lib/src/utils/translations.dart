import 'dart:ui';

import 'package:get/get.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": {
          "title": "Jeet Ke Jeo",
          "play": "Play",
          "purchase": "Purchase",
          "change-language": "Change Language",
          "logout": "Logout",
          "sigin-failed": "Sign in failed",
          "sigin-failed-desc":
              "Please check your email and password and try again.",
          "signup-failed": "Sign up failed",
          "signup-failed-desc":
              "Please check your email and password and try again.",
          "welcome-back": "Welcome\nBack",
          "card-1": "Create an account or log in to your existing account.",
          "card-2": "Click the lottery numbers you would like to play.",
          "card-3": "Click on Play Button.",
          "card-4": "Fill the Details with address and phone number.",
          "card-5": "Purchase the lottery",
          "card-6": "Wait for the results to be announced.",
        },
        "ur_PK": {
          "title": "جیت کے جیو",
          "play": "کھیلیں",
          "purchase": "خریدیں",
          "change-language": "زبان تبدیل کریں",
          "logout": "لاگ آؤٹ",
          "sigin-failed": "سائن ان میں ناکامی",
          "sigin-failed-desc":
              "براہ کرم اپنا ای میل اور پاس ورڈ چیک کریں اور دوبارہ کوشش کریں۔",
          "signup-failed": "سائن اپ میں ناکامی",
          "signup-failed-desc":
              "براہ کرم اپنا ای میل اور پاس ورڈ چیک کریں اور دوبارہ کوشش کریں۔",
          "card-1": "ایک اکاؤنٹ بنائیں یا اپنے موجودہ اکاؤنٹ میں لاگ ان کریں۔",
          "card-2": "لاری کے نمبرز پر کلک کریں جو آپ کھیلنا چاہتے ہیں۔",
          "card-3": "پلے بٹن پر کلک کریں۔",
          "card-4": "پتہ اور فون نمبر کے ساتھ تفصیلات بھریں۔",
          "card-5": "لاری خریدیں",
          "card-6": "نتائج کا اعلان ہونے کا انتظار کریں۔",
        }
      };

  static void changeLocale(String locale, String countryCode) {
    Get.updateLocale(Locale(locale, countryCode));
  }
}
