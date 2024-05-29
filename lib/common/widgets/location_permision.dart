import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/notification/domain/models/notification_body_model.dart';
import '../../helper/route_helper.dart';
import '../../util/app_constants.dart';
import 'button_view.dart';

class LocationPermissionScreen extends StatefulWidget {
  final NotificationBodyModel? body;

  const LocationPermissionScreen({super.key, this.body});

  @override
  State<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {

  SharedPreferences? sharedPreferences;
  setIsUserAcceptLocation() async {
   sharedPreferences =
        await SharedPreferences.getInstance();

    
  }

  final Uri _url = Uri.parse('https://getfastfood.ng/privacy-policy');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  void initState() {
    setIsUserAcceptLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SafeArea(
                  child: SizedBox(
                height: 20,
              )),
              const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.location_on,
                    size: 65,
                    color: Colors.red,
                  )),
              const SizedBox(
                height: 20,
              ),
              const Center(
                  child: Text(
                'Use your Location',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              )),
              const SizedBox(
                height: 30,
              ),
              const Text(
                """This app collects location data to enable real-time tracking of delivery riders, updating customers with the rider's current location, and optimizing delivery routes, even when the app is closed or not in use. If you consent to this permission, please continue. If not, please exit the app.
        """,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  _launchUrl();
                },
                child: const Align(
                  child: Text(
                    'https://getfastfood.ng/privacy-policy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decorationColor: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Image.asset('assets/image/google-maps.jpeg')
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonView(
                onPressed: () async {
                   exit(0);
                },
                expanded: false,
                color: Colors.red,
                borderColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: const Text(
                  'No Thanks',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ButtonView(
                onPressed: () {
                  

                  sharedPreferences?.setString(AppConstants.isSelectLocation, 'selected');

                Get.offNamed(RouteHelper.getSplashRoute(widget.body));

                },
                expanded: false,
                color: Colors.green,
                borderColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                child: const Text(
                  'I Agree',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
