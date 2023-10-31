import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../utils/custom_color.dart';
import '../../../utils/dimensions.dart';
import '../../backend/backend_utils/custom_snackbar.dart';
import '../../backend/services/api_endpoint.dart';
import '../../controller/dashboard/update_profile/update_profile_controller.dart';
import '../others/custom_image_widget.dart';

File? imageFile;
File? pickedFile;
ImagePicker imagePicker = ImagePicker();

class InputImageController extends GetxController {
  var isImagePathSet = false.obs;
  var imagePath = "".obs;

  void setImagePath(String path) {
    imagePath.value = path;
    isImagePathSet.value = true;
  }
}

class ImagePickerWidget extends StatelessWidget {
  ImagePickerWidget({Key? key}) : super(key: key);
  final controller = Get.put(UpdateProfileController());
  final imgController = Get.put(InputImageController());

  // image picker function
  Future pickImage(imageSource) async {
    try {
      final image = await ImagePicker().pickImage(
        source: imageSource,
        imageQuality: 40, // define image quality
        maxHeight: 600, // image height
        maxWidth: 600, // image width
      );
      if (image == null) return;

      imageFile = File(image.path);
      imgController.setImagePath(imageFile!.path);
    } on PlatformException catch (e) {
      CustomSnackBar.error('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Center(
        child: imgController.isImagePathSet.value == true
            ? GestureDetector(
                onTap: () {
                  showGeneralDialog(
                    barrierDismissible: false,
                    context: context,
                    pageBuilder: (ctx, a1, a2) {
                      return const Icon(
                        Icons.close,
                        color: Colors.red,
                      );
                    },
                    transitionBuilder: (ctx, a1, a2, child) {
                      var curve = Curves.easeInOut.transform(a1.value);
                      return Transform.scale(
                        scale: curve,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius * 2),
                          ),
                          content: _imagePickerBottomSheetWidget(context),
                        ),
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 400),
                  );
                },
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: Dimensions.paddingSize,
                      bottom: Dimensions.paddingSize,
                    ),
                    height: Dimensions.heightSize * 8.3,
                    width: Dimensions.widthSize * 11.5,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius * 1.5),
                        color: CustomColor.primaryLightColor,
                        border: Border.all(
                            color: CustomColor.primaryLightColor, width: 4),
                        image: DecorationImage(
                            image: FileImage(
                              File(
                                imgController.imagePath.value,
                              ),
                            ),
                            fit: BoxFit.cover)),
                  ),
                ),
              )
            : _userImageWidget(context),
      );
    });
  }

  _imagePickerBottomSheetWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.13,
      margin: EdgeInsets.all(Dimensions.marginSizeVertical * 0.2),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(Dimensions.paddingSize * 0.5),
                child: IconButton(
                    onPressed: () {
                      Get.back();
                      pickImage(ImageSource.gallery);
                    },
                    icon: Icon(
                      Icons.image,
                      color: Theme.of(context).primaryColor,
                      size: 45,
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.paddingSize * 0.5),
                child: IconButton(
                    onPressed: () {
                      Get.back();
                      pickImage(ImageSource.camera);
                    },
                    icon: Icon(
                      Icons.camera,
                      color: Theme.of(context).primaryColor,
                      size: 45,
                    )),
              ),
            ],
          ),
          Positioned(
            top: -12,
            right: -15,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _userImageWidget(BuildContext context) {
    var data = controller.profileModel.data;
    final image =
        "${ApiEndpoint.mainDomain}/${data.imagePaths.pathLocation}/${data.userInfo.image}";
    final defaultImage =
        "${ApiEndpoint.mainDomain}/${data.imagePaths.defaultImage}";
    return Stack(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(
              top: Dimensions.paddingSize,
              bottom: Dimensions.paddingSize,
            ),
            height: Dimensions.heightSize * 8.3,
            width: Dimensions.widthSize * 11.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
              border:
                  Border.all(color: CustomColor.primaryLightColor, width: 4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.radius),
              child: FadeInImage(
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                image: NetworkImage(data.imagePaths.pathLocation.isNotEmpty
                    ? image
                    : defaultImage),
                placeholder: AssetImage(
                  Assets.clipart.sampleProfile.path,
                ),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    Assets.clipart.sampleProfile.path,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            showGeneralDialog(
              barrierDismissible: false,
              context: context,
              pageBuilder: (ctx, a1, a2) {
                return const Icon(
                  Icons.close,
                  color: Colors.red,
                );
              },
              transitionBuilder: (ctx, a1, a2, child) {
                var curve = Curves.easeInOut.transform(a1.value);
                return Transform.scale(
                  scale: curve,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radius * 2),
                    ),
                    content: _imagePickerBottomSheetWidget(context),
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 400),
            );
          },
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.marginSizeVertical * 2.6),
              child: CustomImageWidget(
                path: Assets.icon.camera,
                color: CustomColor.whiteColor,
                height: Dimensions.heightSize * 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
