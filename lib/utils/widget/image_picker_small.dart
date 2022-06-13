// import 'dart:io';

// import 'package:adm_enhancement_flutter/resources/resources.dart';
// import 'package:adm_enhancement_flutter/utills/helper/file_manager.dart';
// import 'package:adm_enhancement_flutter/utills/widget/bottom_sheet_helper.dart';
// import 'package:adm_enhancement_flutter/utills/widget/forms/form_image_picker.dart';
// import 'package:adm_enhancement_flutter/utills/widget/image_source_sheet.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ImagePickerSmallWidget extends StatelessWidget {
//   const ImagePickerSmallWidget({
//     Key? key,
//     required this.previewHeight,
//     required this.placeholderImage,
//     required this.previewWidth,
//     required this.state,
//     required this.maxHeight,
//     required this.maxWidth,
//     required this.imageQuality,
//     required this.preferredCameraDevice,
//     required this.bottomSheetPadding,
//     required this.cameraIcon,
//     required this.cameraLabel,
//     required this.galleryIcon,
//     required this.galleryLabel,
//     required this.field,
//     required this.onChanged,
//     required this.theme,
//     this.colorDottedBorder,
//   }) : super(key: key);

//   final double previewHeight;
//   final ImageProvider<Object>? placeholderImage;
//   final double previewWidth;
//   final FormImagePickerState state;
//   final double? maxHeight;
//   final double? maxWidth;
//   final int? imageQuality;
//   final CameraDevice preferredCameraDevice;
//   final EdgeInsets bottomSheetPadding;
//   final Widget cameraIcon;
//   final Widget cameraLabel;
//   final Widget galleryIcon;
//   final Widget galleryLabel;
//   final FormImagePickerState field;
//   final ValueChanged<List?>? onChanged;
//   final ThemeData theme;
//   final Color? colorDottedBorder;

//   @override
//   Widget build(BuildContext context) {
//     if (field.value != null && field.value!.isNotEmpty) {
//       var item = field.value?[0];
//       assert(item is File);
//       //add if needed|| item is String || item is Uint8List

//       return buildUIWithItem(item);
//     } else {
//       return buildUINoItem();
//     }
//   }

//   Stack buildUIWithItem(item) {
//     return Stack(
//       alignment: Alignment.topRight,
//       children: <Widget>[
//         Container(
//           width: previewWidth,
//           height: previewHeight * 2.7,
//           margin: EdgeInsets.zero,
//           child: Stack(
//             children: [
//               Container(
//                 alignment: Alignment.topCenter,
//                 child: Container(
//                     height: (previewHeight * 3) - 6,
//                     width: previewWidth,
//                     decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(6.0))),
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(6),
//                         child: Image.file(item as File, fit: BoxFit.cover))),
//               ),
//               InkWell(
//                 onTap: () {
//                   var file = item;
//                   FileManager.launchOpenFile(file.path);
//                 },
//                 child: Container(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                       height: (previewHeight * 2) * 0.4,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: <Color>[
//                             Resources.color.textColor.withOpacity(0.0),
//                             Resources.color.textColor.withOpacity(0.6),
//                           ],
//                         ),
//                         borderRadius: const BorderRadius.vertical(
//                             bottom: Radius.circular(6.0)),
//                       ),
//                       child: Row(
//                         children: [
//                           const Icon(
//                             Icons.visibility,
//                             size: 20,
//                           ),
//                           Text(
//                             "Lihat",
//                             style: TextStyle(
//                                 fontSize: 10, color: Resources.color.white),
//                           )
//                         ],
//                       )),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             state.requestFocus();
//             field.didChange(<dynamic>[...?field.value]..remove(item));
//           },
//           child: Container(
//             margin: const EdgeInsets.all(3),
//             decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(.7),
//               shape: BoxShape.circle,
//             ),
//             alignment: Alignment.center,
//             height: 22,
//             width: 22,
//             child: const Icon(
//               Icons.close,
//               size: 18,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   InputDecorator buildUINoItem() {
//     return InputDecorator(
//       decoration: InputDecoration(
//         fillColor: theme.scaffoldBackgroundColor,
//         contentPadding: EdgeInsets.zero,
//         border: InputBorder.none,
//         errorText: field.errorText,
//         enabledBorder: InputBorder.none,
//         errorBorder: InputBorder.none,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 2.0),
//         child: GestureDetector(
//           child: DottedBorder(
//             dashPattern: const [3, 3, 2, 3],
//             color: field.errorText != null
//                 ? Resources.color.errorColor
//                 : colorDottedBorder ?? Resources.color.colorPrimary,
//             borderType: BorderType.RRect,
//             radius: const Radius.circular(12),
//             child: SizedBox(
//               height: previewHeight,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   placeholderImage != null
//                       ? Image(
//                           width: previewWidth,
//                           height: previewHeight,
//                           image: placeholderImage!,
//                         )
//                       : Container(
//                           alignment: Alignment.center,
//                           width: previewWidth,
//                           height: previewHeight,
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.attach_file,
//                                 color: colorDottedBorder,
//                               ),
//                               Text(
//                                 "Unggah Gambar",
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     color: field.errorText != null
//                                         ? Resources.color.errorColor
//                                         : colorDottedBorder ??
//                                             Resources.color.colorPrimary),
//                               ),
//                             ],
//                           )),
//                 ],
//               ),
//             ),
//           ),
//           onTap: () {
//             showBarBottomSheet<void>(
//               state.context,
//               builder: (_) {
//                 return ImageSourceBottomSheet(
//                   maxHeight: 1700,
//                   maxWidth: 1700,
//                   imageQuality: imageQuality,
//                   preferredCameraDevice: preferredCameraDevice,
//                   bottomSheetPadding: bottomSheetPadding,
//                   cameraIcon: cameraIcon,
//                   cameraLabel: cameraLabel,
//                   galleryIcon: galleryIcon,
//                   galleryLabel: galleryLabel,
//                   onImageSelected: (image) {
//                     // final bytes = image.readAsBytesSync().lengthInBytes;
//                     // final kb = bytes / 1024;
//                     // final mb = kb / 1024;
//                     // debugPrint("Size File is => $mb Mb or $kb Kb");
//                     state.requestFocus();
//                     field.didChange(<dynamic>[...?field.value, image]);
//                     Navigator.pop(state.context);
//                   },
//                   onImage: (image) {
//                     // final bytes = image.lengthInBytes;
//                     // final kb = bytes / 1024;
//                     // final mb = kb / 1024;
//                     // debugPrint("Size File is => $mb Mb or $kb Kb");
//                     field.didChange(<dynamic>[...?field.value, image]);
//                     onChanged?.call(field.value);
//                     Navigator.pop(state.context);
//                   },
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
