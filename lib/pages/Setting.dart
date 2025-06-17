import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gan/widgets/AppButton.dart';
import 'package:gan/widgets/LabeledInputBox.dart';
import 'package:gan/widgets/LabeledInputBox.dart';
import 'package:flutter/services.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/widgets/TopBar.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<Setting> {
  static Future<void> saveSetting({
    required String username,
    required String bio,
    required String location,
    required bool EnablePostNotifications,
    required bool EnableNearbyMissingPetNotifications,
    required bool EnableGroupChatMessages,
  }) async {
    final SettingData = {
      "username": username,
      "bio": bio,
      "location": location,
      "enablePostNotifications": EnablePostNotifications,
      "enableNearbyNotifications": EnableNearbyMissingPetNotifications,
      "enableGroupChatMessages": EnableGroupChatMessages,
      "uid": AuthService.uid,
    };
    print(SettingData);
    await AuthService.db
        .collection("settings")
        .doc(AuthService.uid)
        .set(SettingData);
  }
  late TextEditingController _UserNamecontroller = TextEditingController();
  late TextEditingController _bioController = TextEditingController();
  late TextEditingController _locationController = TextEditingController();
  bool EnablePostNotifications = false;
  bool EnableNearbyMissingPetNotifications = false;
  bool EnableGroupChatMessages = false;

  @override
  void initState() {
    super.initState();
    _UserNamecontroller = TextEditingController(
      text: AuthService.userData['username'], // 假设从用户数据获取
    );
    _bioController = TextEditingController(); // 先初始化
    _loadUserBio(); // 异步加载
  }

  Future<void> _loadUserBio() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await AuthService.db
          .collection("settings")
          .doc(AuthService.uid)
          .get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          setState(() {
            _bioController.text = data['bio'] ?? "";
            _locationController.text = data['location'] ?? "";
            EnablePostNotifications = data['enablePostNotifications'] ?? false;
            EnableNearbyMissingPetNotifications = data['enableNearbyNotifications'] ?? false;
            EnableGroupChatMessages = data['enableGroupChatMessages'] ?? false;

          });
        }
      } else {
        print('User settings not found.');
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  void dispose() {
    _UserNamecontroller.dispose();
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
                          onPressed: () => {
                            saveSetting(
                              username: _UserNamecontroller.text,
                              bio: _bioController.text,
                              location: _locationController.text,
                              EnablePostNotifications: EnablePostNotifications,
                              EnableNearbyMissingPetNotifications:
                              EnableNearbyMissingPetNotifications,
                              EnableGroupChatMessages: EnableGroupChatMessages,
                            ),
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
                          textController: _UserNamecontroller,
                          isInputLocation: false,
                          width: 370,
                          showCatIcon: false,
                          showPencilIcon: true,
                        ),
                        LabeledInputBox(
                          label: "Bio",
                          placeholder:
                              "Add a short bio to let others know who you are",
                          textController: _bioController,
                          isInputLocation: false,
                          width: 370,
                          height: 80,
                          showCatIcon: false,
                          showPencilIcon: true,
                          maxLines: 2,
                        ),
                        LabeledInputBox(
                          label: "Location",
                          textController: _locationController,
                          placeholder: "Your Location",
                          isInputLocation: true,
                          width: 370,
                          showCatIcon: false,
                          showPencilIcon: true,
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
                                  value: EnablePostNotifications,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      EnablePostNotifications = value ?? false;
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
                                  value: EnableNearbyMissingPetNotifications,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      EnableNearbyMissingPetNotifications =
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
                                  value: EnableGroupChatMessages,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      EnableGroupChatMessages = value ?? false;
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
                            image: DecorationImage(
                              image: AssetImage("https://placehold.co/117x118"),
                              fit: BoxFit.contain,
                            ),
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
