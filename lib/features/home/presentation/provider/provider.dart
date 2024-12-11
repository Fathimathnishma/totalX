import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:totalxtestapp/features/home/data/i_mainfacade.dart';
import 'package:totalxtestapp/features/home/data/model/user_model.dart';

import 'package:totalxtestapp/general/services/setsearch.dart';
import 'package:totalxtestapp/general/utils/firebase_collection.dart';

class MainProvider extends ChangeNotifier {

    final IMainfacade iMainfacade;
  MainProvider(
    this.iMainfacade,
  );

//contrllers
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();


  List<Usermodel> allUsers = [];
  int selectAgeCategory = 0;
  final SearchController searchController = SearchController();
  DocumentSnapshot? lastDoc;
  bool isLoading = false;
  bool noMoreData = false;

  bool get isValid => name != null && age != null;

  String? name;
  int? age;
  List? search;
    final userCollection =FirebaseFirestore.instance.collection(FirebaseCollection.users);

  // void setUser({
  //   required int age,
  //   required String name,
  //   required List search,
  // }) {
  //   this.age = age;
  //   this.name = name;
  //   this.search = search;
  //   notifyListeners();
  // }

  // Future<void> addUser({
  // }) async {
  //   if (isValid) {
  //     Usermodel user = Usermodel(name: name!, age: age!, search: search!);

  //     try {
  //       final usercollection = FirebaseFirestore.instance.collection("users");

  //       await usercollection.add(user.toMap());
  //       name = null;
  //       age = null;
  //       allUsers.insert(0, user);
  //       notifyListeners();
  //     //  Navigator.pop(context);
  //       Fluttertoast.showToast(msg: "User added successfully!");
  //     } catch (e) {
  //      // Navigator.pop(context);
  //       Fluttertoast.showToast(msg: "Error adding user: ${e.toString()}");

  //     }
  //   } else {
  //   //  ScaffoldMessenger.of(context)
  //        // .showSnackBar(const SnackBar(content: Text("Invalid data")));
  //   }
  // }

  Future<void> addUser(
   {
    required void Function(String) errors,
    required void Function() onSuccess,
  }) async {
    final usermodel = Usermodel(
      name: nameController.text,
      age: int.parse(ageController.text),
      search: generateKeywords(nameController.text),
      createdAt: Timestamp.now(),
      id: userCollection.doc().id,
    );

  final result=await iMainfacade.addUsers(usermodel: usermodel);

  result.fold((l) {
    errors.call(l.errormsg);
  }, (r) {
    allUsers.add(usermodel);
    onSuccess.call();
  },);
  notifyListeners();
  }

  Future<void> addShowDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (
        context,
      ) {
        return const PopScope(
          canPop: false,
          child: AlertDialog(
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text("Adding User"),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> getData({int? selectAge, String? search}) async {
    isLoading = true;
    notifyListeners();
    final result =
        await iMainfacade.fetchData(selectAge: selectAge, search: search);
    result.fold(
      (l) {
        l.toString();
      },
      (r) {
        log(r.length.toString());
        if(r.isEmpty){
          noMoreData=true;
        }else{
           allUsers.addAll(r);
        }
       
      },
    );
    isLoading = false;
    notifyListeners();
  }
  



// Future<void> _getData({int? selectAge, String? search}) async {
//     final usercollection = FirebaseFirestore.instance.collection("users");

//     if (isLoading || noMoreData) {
//       return;
//     }
//     isLoading = true;
//     Query query = usercollection.orderBy("age", descending: false);
//     try {
//       if (selectAge == 1) {
//         query = query.where("age", isGreaterThanOrEqualTo: 50);
//       } else if (selectAge == 2) {
//         query = query.where("age", isLessThanOrEqualTo: 50);
//       }
//       if (search != null && search.isNotEmpty) {
//         query = query.where("search", arrayContains: search.toLowerCase());
//       }
//       if (lastDoc != null) {
//         query = query.startAfterDocument(lastDoc!);
//       }

//       QuerySnapshot snapshotlimit = await query.limit(10).get();

//       if (snapshotlimit.docs.isNotEmpty) {
//         final userData = snapshotlimit.docs
//             .map((doc) => Usermodel.fromMap(doc.data() as Map<String, dynamic>))
//             .toList();
//         // log("qqq.l${userData.length}");

//         lastDoc = snapshotlimit.docs.last;
//         allUsers.addAll(userData);
//       }
//       // log("qqq.l${allUsers.length}");

//       if (snapshotlimit.docs.length < 10) {
//         noMoreData = true;
//       }
//     } catch (e) {
//       print(e.toString());
//       log(e.toString());
//     } finally {
//       isLoading = false;

//       notifyListeners();
//     }
//   }

//   Future<void> initData({
//     required ScrollController scrollController,
//   }) async {
//     if (searchController.text != "") {
//       clearData();
//      // await _getData();
//     } else {
//      // await _getData(
//       //    selectAge: selectAgeCategory, search: searchController.text);
//     }
//     scrollController.addListener(() async {
//       if (scrollController.position.pixels >=
//           scrollController.position.maxScrollExtent - 100) {
//         try {
//         //  await _getData(
//               //selectAge: selectAgeCategory, search: searchController.text);
//         } catch (e) {
//           log("error${e.toString()}");
//         }
//       }
//     });
//   }


  Future<void> initData({
    required ScrollController scrollController,
  }) async {
    if (searchController.text != "") {
      clearData();
      await getData(selectAge:selectAgeCategory,search: searchController.text );
    } else {
      await getData(
          selectAge: selectAgeCategory, search: searchController.text);
    }
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 70) {
        try {
          await getData(
              selectAge: selectAgeCategory, search: searchController.text);
        } catch (e) {
          log("error${e.toString()}");
        }
      }
    });
  }

  Future<void> updateFilter(
      {required ScrollController scrollController,
      required int agevalue}) async {
    selectAgeCategory = agevalue;
    clearData();
    await initData(
      scrollController: scrollController,
    );
    notifyListeners();
  }

  void clearData() {
    log("clearing data");
    iMainfacade.clearData();
    allUsers = [];
    search = null;
    isLoading=false;
    noMoreData = false;
    lastDoc = null;
  }

}

