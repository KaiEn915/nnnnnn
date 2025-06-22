import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:gan/pages/PetImageAnalysis.dart';
import 'package:gan/services/ImageService.dart';
import 'package:gan/widgets/TopBar.dart';
import 'package:image_picker/image_picker.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<StatefulWidget> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(_cameras![0], ResolutionPreset.medium);
      await _controller!.initialize();
      setState(() {
        _isInitialized = true;
      });
    }
    print("initialized");
  }

  Future<void> _takePicture() async {
    if (_controller != null && _controller!.value.isInitialized) {
      final image = await _controller!.takePicture();

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              PetImageAnalysis(image: image),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: Duration(milliseconds: 500),
        ),
      );
    }
  }



  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: 133,
            child: Container(
              //里面透明的
              width: 392,
              height: 392,
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 15),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white.withAlpha(70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3FBCBCBC),
                    blurRadius: 4,
                    offset: Offset(0, 5),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      width: 300,
                      height: 300,
                      color: Colors.black,
                      child: _isInitialized
                          ? FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: _controller!.value.previewSize!.height,
                                height: _controller!.value.previewSize!.width,
                                child: CameraPreview(_controller!),
                              ),
                            )
                          : Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 165,
            top: 100,
            child: Container(
              width: 70,
              height: 75,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/love.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            //下面透明的
            left: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 100,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: const Color(0xBFDEDEDE)),
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 70,
                            top: 15,
                            child: Container(
                              width: 270,
                              height: 70,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: const Color(0xFFDFDFDF),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 15,
                                    top: 8,
                                    child: Icon(Icons.upload, size: 50),
                                  ),
                                  Positioned(
                                    left: 80,
                                    top: 5,
                                    child: GestureDetector(
                                      onTap: () async {
                                        XFile? _image=await ImageService.pickImage(ImageSource.gallery);
                                        if (_image==null) return;
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation, secondaryAnimation) =>
                                                PetImageAnalysis(image: _image),
                                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                              return FadeTransition(opacity: animation, child: child);
                                            },
                                            transitionDuration: Duration(milliseconds: 500),
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        width: 170,
                                        height: 80,
                                        child: Text(
                                          'Upload',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFF828282),
                                            fontSize: 35,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            height: 1.40,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            left: 60,
            top: 620,
            child: Container(
              width: 300,
              height: 100,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: GestureDetector(
                onTap: _takePicture,
                child: Positioned(
                  left: 105,
                  top: 12,
                  child: Icon(Icons.camera_alt_outlined, size: 80),
                ),
              ),
            ),
          ),
          Positioned(
            left: 280,
            top: 460,
            child: Container(
              width: 140,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/cat.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 560,
            child: Container(
              width: 150,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Cat3.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          TopBar(
            isMiddleSearchBar: false,
            header: "TAKE A PICTURE",
            leftIcon: Icons.arrow_back,
            leftIcon_onTap: () => {Navigator.pop(context)},
          ),
        ],
      ),
    );
  }
}
