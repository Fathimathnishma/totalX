// import 'package:flutter/material.dart';
// import 'package:totalxtestapp/main.dart';

// class SortBottomSheet extends StatefulWidget {
//   const SortBottomSheet({super.key});

//   @override
//   State<SortBottomSheet> createState() => _SortBottomSheetState();
// }

// //int selectAgeCategory = 0;

// class _SortBottomSheetState extends State<SortBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height * 0.2,
//       width: width * 1,
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Radio(
//                 value: 0,
//                 groupValue: selectAgeCategory,
//                 onChanged: (value) {
//                   selectAgeCategory = value!;
//                   Navigator.pop(context);
//                 },
//               ),
//               const Text("All")
//             ],
//           ),
//           Row(
//             children: [
//               Radio(
//                 value: 1,
//                 groupValue: selectAgeCategory,
//                 onChanged: (value) {
//                   selectAgeCategory = value!;
//                    Navigator.pop(context);
//                 },
//               ),
//               const Text("above 50")
//             ],
//           ),
//           Row(
//             children: [
//               Radio(
//                 value: 2,
//                 groupValue: selectAgeCategory,
//                 onChanged: (value) {
//                   selectAgeCategory = value!;
//                    Navigator.pop(context);
//                 },
//               ),
//               const Text("below 50")
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
