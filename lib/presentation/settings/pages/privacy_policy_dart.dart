import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hog_v2/common/constants/colors.dart';
import 'package:hog_v2/presentation/settings/widgets/about_the_policy.dart';
import 'package:hog_v2/presentation/settings/widgets/privacy_policy_item.dart';
import 'package:hog_v2/presentation/settings/widgets/privacy_policy_title.dart';

class PricyPolicy extends StatelessWidget {
  const PricyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Privacy Policys",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: kprimaryBlueColor, fontSize: 18.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const PrivacyPolicyTitle(title: "1.Informations We Collect"),
              const AboutThePolicyWidget(
                  text: "When you use our app, we may collect the following types of information:"),
              const PrivacyPolicyItem(
                  text:
                      "Personal Information: This includes your name, email address, and any other information you provide during account creation or while using our app."),
              const PrivacyPolicyItem(
                  text:
                      "Device Information: We may collect details about your device, such as the device model and operating system."),
              const PrivacyPolicyItem(
                  text:
                      "Usage Data: This includes information about how you use our app, such as which features you access and the time you spend using the app."),
              SizedBox(
                height: 40.h,
              ),
              const PrivacyPolicyTitle(title: "2. How We Use Your Information"),
              const AboutThePolicyWidget(text: "We use the information we collect to:"),
              const PrivacyPolicyItem(text: "Provide and maintain the functionality of our app."),
              const PrivacyPolicyItem(text: "Personalize your experience within our app."),
              const PrivacyPolicyItem(text: "Analyze app usage for improvements."),
              const PrivacyPolicyItem(text: "Send important notifications and updates."),
              SizedBox(
                height: 40.h,
              ),
              const PrivacyPolicyTitle(title: "3. Sharing Your Information"),
              const AboutThePolicyWidget(
                  text:
                      "We do not sell your personal information. However, we may share your data with third parties for the following purposes:"),
              const PrivacyPolicyItem(
                  text:
                      "Analytics: To understand user behavior and improve the app's performance."),
              const PrivacyPolicyItem(
                  text: "Service Providers: To assist with app-related services."),
              SizedBox(
                height: 40.h,
              ),
              const PrivacyPolicyTitle(title: "4. Your Rights"),
              const AboutThePolicyWidget(text: "You have the right to:"),
              const PrivacyPolicyItem(text: "Access your data."),
              const PrivacyPolicyItem(text: "Correct inaccuracies in your data."),
              const PrivacyPolicyItem(text: "Delete your data."),
              SizedBox(
                height: 40.h,
              ),
              const PrivacyPolicyTitle(title: "5. Security"),
              const AboutThePolicyWidget(
                  text:
                      "We implement robust security measures, including encryption and access controls, to protect your data from unauthorized access and misuse."),
              SizedBox(
                height: 40.h,
              ),
              const PrivacyPolicyTitle(title: "6. Changes to This Privacy Policy"),
              const AboutThePolicyWidget(
                  text:
                      "We may update this Privacy Policy from time to time. We will notify you of any significant changes. Your continued use of the app after such modifications implies your consent."),
            ],
          ),
        ),
      ),
    );
  }
}
