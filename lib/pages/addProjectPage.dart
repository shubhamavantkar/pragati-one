// import 'package:flutter/material.dart';
// import 'package:pragati/widgets/formTextField.dart';

// class AddProjectPage extends StatelessWidget {
//   AddProjectPage({super.key});

//   TextEditingController _proectNameCntroller = TextEditingController();
//   TextEditingController _cientNameController = TextEditingController();
//   TextEditingController _projectocationController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           FormTextField(
//               controller: _proectNameCntroller,
//               hintText: 'Enter Project Name',
//               label: 'Project Name',
//               prefixImage: Image.asset('name')),
//           SizedBox(
//             height: 10,
//           ),
//           FormTextField(
//               controller: _cientNameController,
//               hintText: 'Enter Client Name',
//               label: 'Client Name',
//               prefixImage: Image.asset('name')),
//           SizedBox(
//             height: 10,
//           ),
//           FormTextField(
//               controller: _projectocationController,
//               hintText: 'Enter Project Location',
//               label: 'Location',
//               prefixImage: Image.asset('name')),
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             children: [
//               // FormTextField(
//               //     hintText: 'Select Date',
//               //     label: 'Start Date',
//               //     prefixImage: Image.asset('name')),
//               // SizedBox(
//               //   width: 10,
//               // ),
//               // FormTextField(
//               //     hintText: 'Select Date',
//               //     label: 'End Date',
//               //     prefixImage: Image.asset('name')),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text('PROJECT PHOTOS'),
//           SizedBox(
//             height: 5,
//           ),
//           SizedBox(
//             height: 30,
//             child: Text('UPLOAD'),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text('WORK ORDER'),
//           SizedBox(
//             height: 30,
//             child: Text('Add Work Package'),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text('RETENTION'),
//           TextField(),
//         ],
//       ),
//     );
//   }
// }
