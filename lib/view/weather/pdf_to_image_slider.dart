// import 'dart:io';
// import 'dart:math';
// import 'dart:typed_data';
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:pdfx/pdfx.dart';
//
// class PdfSlider extends StatefulWidget {
//   @override
//   _PdfSliderState createState() => _PdfSliderState();
// }
//
// class _PdfSliderState extends State<PdfSlider> {
//   PageController pageController = PageController(viewportFraction: 8);
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FutureBuilder(
//           future: getImage(),
//           builder: (BuildContext context,
//               AsyncSnapshot<List<PdfPageImage>?> snapshot) {
//             if (snapshot.hasData) {
//               return CarouselSlider.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder:
//                     (BuildContext context, int itemIndex, int pageViewIndex) {
//                   PdfPageImage image = snapshot.data![itemIndex];
//                   return Container(
//                     padding: EdgeInsets.all(10),
//                     color: Colors.grey,
//                     margin: EdgeInsets.all(5),
//                     child: Image.memory(
//                       image.bytes,
//                       height: 400,
//                       width: 400,
//                       fit: BoxFit.cover,
//                     ),
//                   );
//                 },
//                 options: CarouselOptions(
//                   height: 400.0,
//                   enableInfiniteScroll: false,
//                 ),
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: CircularProgressIndicator(color: Colors.red),
//               );
//             } else {
//               return Center(
//                 child: CircularProgressIndicator(color: Colors.green),
//               );
//             }
//           }, //<- created image
//         ),
//       ),
//     );
//   }
//
//   Future<Uint8List> urlToUint8List(String url) async {
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       return Uint8List.fromList(response.bodyBytes);
//     } else {
//       throw Exception('Failed to load data from URL');
//     }
//   }
//
//   Future<List<PdfPageImage>?> getImage() async {
//     List<PdfPageImage>? pageList = [];
//
//     try {
//       final uint8List =
//           await urlToUint8List('http://www.pdf995.com/samples/pdf.pdf');
//       final document = await PdfDocument.openData(uint8List);
//
//       for (int i = 0; i < await document.pagesCount; i++) {
//         final page = await document.getPage(i + 1);
//
//         final image = await page.render(
//           width: page.width * 2, //decrement for less quality
//           height: page.height * 2,
//           format: PdfPageImageFormat.jpeg,
//           backgroundColor: '#ffffff',
//         );
//         pageList.add(image!);
//       }
//       return pageList;
//     } catch (e) {
//       print('-----EROR---${e}');
//
//       return pageList;
//     }
//   }
// }
//
// /// FOR FILE
// //File data = await urlToFile('http://www.pdf995.com/samples/pdf.pdf');
// Future<File> urlToFile(String imageUrl) async {
//   // generate random number.
//   var rng = new Random();
//   // get temporary directory of device.
//   Directory tempDir = await getTemporaryDirectory();
//   // get temporary path from temporary directory.
//   String tempPath = tempDir.path;
//   // create a new file in temporary path with random file name.
//   File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
//   // call http.get method and pass imageurl into it to get response.
//   http.Response response = await http.get(Uri.parse(imageUrl));
//   // write bodybytes received in response to file.
//   await file.writeAsBytes(response.bodyBytes);
//   // now return the file which is created with random name in
//   // temporary directory and image bytes from response is written to // that file.
//   return file;
// }
