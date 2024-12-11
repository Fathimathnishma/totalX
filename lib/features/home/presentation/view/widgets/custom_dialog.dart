
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxtestapp/features/home/presentation/provider/provider.dart';
import 'package:totalxtestapp/general/utils/app_colors.dart';
import 'package:totalxtestapp/main.dart';

class CustomDialogWid extends StatefulWidget {
  const CustomDialogWid({super.key});

  @override
  State<CustomDialogWid> createState() => _CustomDialogWidState();
}

class _CustomDialogWidState extends State<CustomDialogWid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorconst.primaryColor.withOpacity(0.7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Dialog(
            child: Consumer<MainProvider>(
              builder: (context, stateUserAdd, child) => Center(
                child: Container(
                  height: height * 0.3,
                  width: width * 1,
                  color: Colorconst.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("New Task"),
                        TextFormField(
                          controller: stateUserAdd.nameController,
                          decoration: const InputDecoration(
                            hintText: "enter your name",
                          ),
                        ),
                        TextFormField(
                          // validator: ,
                          controller: stateUserAdd.ageController,
                          decoration: const InputDecoration(
                            hintText: "enter your age",
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        InkWell(
                          onTap: () async {
                            if (stateUserAdd.nameController.text.isNotEmpty &&
                                stateUserAdd.ageController.text.isNotEmpty) {
                              try {
                               // int age = int.parse(stateUserAdd.ageController.text);
                                stateUserAdd.addUser( errors: (p0) {
                                    
                                },
                                 onSuccess:() {
                                  stateUserAdd.addShowDialog(context);
                                   Navigator.pop(context);
                                },
                                );
                                // stateUserAdd.setUser(
                                //     age: age, name: stateUserAdd.nameController.text, search: generateKeywords ("${stateUserAdd.nameController.text} ${stateUserAdd.ageController.text}"));
                              
                                //await stateUserAdd.addUser(context);
                               stateUserAdd. nameController.clear();
                                stateUserAdd.ageController.clear();
                                Navigator.pop(context);
                              
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(" invalid Name or Age")));
                              }
                            }
                          },
                          child: Container(
                              height: height * 0.05,
                              width: width * 0.2,
                              decoration: BoxDecoration(
                                  color: Colorconst.primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(width * 0.02)),
                              child: const Center(
                                child: Text(
                                  "Create",
                                  style:
                                      TextStyle(color: Colorconst.whiteColor),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
