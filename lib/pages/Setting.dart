import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/services/MapService.dart';
import 'package:gan/widgets/AppButton.dart';
import 'package:gan/widgets/LabeledInputBox.dart';
import 'package:flutter/services.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/widgets/TopBar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingWidgetState();

}

class _SettingWidgetState extends State<Setting> {
  static Future<void> saveSetting({
    required String username,
    required String bio,
    required GeoPoint? locationCoordinates,
    required bool enablePostNotifications,
    required bool enableNearbyMissingPetNotifications,
    required bool enableGroupChatMessages,
  }) async {
    final settingData = {
      "username": username,
      "bio": bio,
      "locationCoordinates": locationCoordinates,
      "enablePostNotifications": enablePostNotifications,
      "enableNearbyMissingPetNotifications": enableNearbyMissingPetNotifications,
      "enableGroupChatMessages": enableGroupChatMessages,
      "uid": AuthService.uid,
    };

    await AuthService.db
        .collection("users")
        .doc(AuthService.uid)
        .update(settingData);

    AuthService.updateUserData();

    Fluttertoast.showToast(
      msg: "Changes saved successfully!",
      backgroundColor: Colors.green,
      textColor: Colors.white,
      gravity: ToastGravity.CENTER
    );

  }
  late TextEditingController usernameController = TextEditingController();
  late TextEditingController bioController = TextEditingController();
  late TextEditingController locationController = TextEditingController();
  bool enablePostNotifications = false;
  bool enableNearbyMissingPetNotifications = false;
  bool enableGroupChatMessages = false;

  @override
  void initState() {
    loadUserSettings();
    super.initState();
  }

  Future<void> loadUserSettings() async{
    await AuthService.updateUserData();
    Map<String,dynamic>? data=AuthService.userData;
    String address=await MapService.getAddressFromCoordinates(data?['locationCoordinates']);
    print("address: $address");


    setState(() {
      usernameController.text=data?['username']??"";
      bioController.text=data?['bio'] ?? "";
      locationController.text=address;
      enableGroupChatMessages=data?['enableGroupChatMessages']??enableGroupChatMessages;
      enableNearbyMissingPetNotifications=data?['enableNearbyMissingPetNotifications']??enableNearbyMissingPetNotifications;
      enablePostNotifications=data?['enablePostNotifications']??enablePostNotifications;
    });



  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background3.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  //the button for save change
                  top: 780,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButton(
                          text: "Save Changes",
                          backgroundColor: Colors.black,
                          onPressed: () async {
                            GeoPoint? coordinates = await MapService.getCoordinatesFromAddress(locationController.text);

                            saveSetting(
                              username: usernameController.text,
                              bio: bioController.text,
                              locationCoordinates: coordinates,
                              enablePostNotifications: enablePostNotifications,
                              enableNearbyMissingPetNotifications: enableNearbyMissingPetNotifications,
                              enableGroupChatMessages: enableGroupChatMessages,
                            );

                            Navigator.pop(context);
                          },
                        ),

                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 280,
                  child: Container(
                    width: 370,
                    height: 470,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 9,
                      children: [
                        LabeledInputBox(
                          label: "username",
                          textController: usernameController,
                          isInputLocation: false,
                          width: 370,
                          showCatIcon: false,
                          showPencilIcon: true,
                        ),
                        LabeledInputBox(
                          label: "Bio",
                          placeholder:
                              "Add a short bio to let others know who you are",
                          textController: bioController,
                          isInputLocation: false,
                          width: 370,
                          height: 80,
                          showCatIcon: false,
                          showPencilIcon: true,
                          maxLines: 2,
                        ),
                        LabeledInputBox(
                          label: "Location",
                          textController: locationController,
                          placeholder: "Your Location",
                          isInputLocation: true,
                          width: 370,
                          showCatIcon: false,
                        ),
                        Container(
                          width: 400,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 9,
                            children: [
                              SizedBox(
                                width: 250,
                                child: Text(
                                  'Enable post notifications',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 1.40,
                                  ),
                                ),
                              ),
                              CheckboxTheme(
                                data: CheckboxThemeData(
                                  visualDensity: VisualDensity(
                                    horizontal: -2,
                                    vertical: -2,
                                  ), // 控制内部密度
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Checkbox(
                                  value: enablePostNotifications,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      enablePostNotifications = value ?? false;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 400,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 9,
                            children: [
                              SizedBox(
                                width: 266,
                                child: Text(
                                  'Enable nearby missing pet notifications',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 1.40,
                                  ),
                                ),
                              ),
                              CheckboxTheme(
                                data: CheckboxThemeData(
                                  visualDensity: VisualDensity(
                                    horizontal: -2,
                                    vertical: -2,
                                  ), // 控制内部密度
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Checkbox(
                                  value: enableNearbyMissingPetNotifications,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      enableNearbyMissingPetNotifications =
                                          value ?? false;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 400,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 9,
                            children: [
                              SizedBox(
                                width: 266,
                                child: Text(
                                  'Enable group chat messages',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 1.40,
                                  ),
                                ),
                              ),
                              CheckboxTheme(
                                data: CheckboxThemeData(
                                  visualDensity: VisualDensity(
                                    horizontal: -2,
                                    vertical: -2,
                                  ), // 控制内部密度
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Checkbox(
                                  value: enableGroupChatMessages,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      enableGroupChatMessages = value ?? false;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 130,
                  top: 155,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 13,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFE6FCFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 117,
                          height: 118,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 16,
                          height: 16,
                          child: Icon(Icons.upload),
                        ),
                      ],
                    ),
                  ),
                ),
                TopBar(
                  isMiddleSearchBar: false,
                  header: "SETTING",
                  leftIcon: Icons.arrow_back,
                  leftIcon_onTap: () => {
                    Navigator.pushNamed(context, "/UserProfile"),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
