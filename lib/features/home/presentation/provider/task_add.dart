import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:totalxtestapp/features/home/data/model/task_model.dart';

class TaskAdd extends ChangeNotifier {
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

  void setUser({
    required int age,
    required String name,
    required List search,
  }) {
    this.age = age;
    this.name = name;
    this.search = search;
    notifyListeners();
  }

  Future<void> addUser(BuildContext context) async {
    if (isValid) {
      Usermodel user = Usermodel(name: name!, age: age!, search: search!);
      //log(showDialog(context: context, builder: builder));

      try {
        final usercollection = FirebaseFirestore.instance.collection("users");

        await usercollection.add(user.toMap());
        name = null;
        age = null;
        allUsers.insert(0, user);
        //  users.indexOf(user,0).add(user);
        notifyListeners();

        Navigator.pop(context);
        Fluttertoast.showToast(msg: "User added successfully!");
      } catch (e) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Error adding user: ${e.toString()}");
        // print(displayUsers);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Invalid data")));
    }
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

  Future<void> _getData({int? selectAge, String? search}) async {
    final usercollection = FirebaseFirestore.instance.collection("users");

    if (isLoading || noMoreData) {
      return;
    }
    isLoading = true;
    Query query = usercollection.orderBy("age", descending: false);
    try {
      if (selectAge == 1) {
        query = query.where("age", isGreaterThanOrEqualTo: 50);
      } else if (selectAge == 2) {
        query = query.where("age", isLessThanOrEqualTo: 50);
      }
      if (search != null && search.isNotEmpty) {
        query = query.where("search", arrayContains: search.toLowerCase());
      }
      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc!);
      }

      QuerySnapshot snapshotlimit = await query.limit(10).get();

      if (snapshotlimit.docs.isNotEmpty) {
        final userData = snapshotlimit.docs
            .map((doc) => Usermodel.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
        log("qqq.l${userData.length}");

        lastDoc = snapshotlimit.docs.last;
        allUsers.addAll(userData);
      }
      log("qqq.l${allUsers.length}");

      if (snapshotlimit.docs.length < 10) {
        noMoreData = true;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
    
      notifyListeners();
    }
  }

  Future<void> initData(
      {required ScrollController scrollController, }) async {
    if(searchController.text!="")
  { clearData();
   await _getData(selectAge: selectAgeCategory, search: searchController.text);
 }  else{
           await _getData(selectAge: selectAgeCategory, search: searchController.text);
        }
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100 
          ) {
        try {
          // if(searchController.text!="") {
    await _getData(selectAge: selectAgeCategory, search: searchController.text);
 // }
  // else{
  //   _getData(selectAge: selectAgeCategory,);
  // }
          
        } catch (e) {
         log("error${e.toString()}");
        }
   
      }
    });
    //  if (search!= null && se) {
    //       clearData();
    //       await _getData(
    //         selectAge: selectAgeCategory,
    //         search: searchController.text,
    //       );
    //     }
        //else{

    //       await _getData();
    //     }
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
    allUsers = [];
    search = null;
    noMoreData = false;
    lastDoc = null;
  }
}
