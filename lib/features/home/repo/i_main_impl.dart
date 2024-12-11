
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:totalxtestapp/features/home/data/i_mainfacade.dart';
import 'package:totalxtestapp/features/home/data/model/user_model.dart';
import 'package:totalxtestapp/general/failures/failures.dart';
import 'package:totalxtestapp/general/utils/firebase_collection.dart';
@LazySingleton(as: IMainfacade)
class IMainImpl implements IMainfacade{
  final FirebaseFirestore firestore;
  IMainImpl(this.firestore);


  //int selectAgeCategory = 0;
  final SearchController searchController = SearchController();
  DocumentSnapshot? lastDoc;
  bool isLoading = false;
  bool noMoreData = false;

  
  @override
  Future<Either<MainFailures, String>> addUsers({required Usermodel usermodel}) async {
    
try{
  final userRef = firestore.collection(FirebaseCollection.users);
  final userId = userRef.doc().id;
  final user =usermodel.copyWith(id: userId);
  
  await userRef.doc(userId).set(user.toMap());
  return right("User added");
} catch (e){
return left(MainFailures.serverFailures(errormsg: e.toString()));
}

  }
  
  @override
  Future<Either<MainFailures, List<Usermodel>>> fetchData({int? selectAge, String? search}) async {
   if (noMoreData) {
      log(noMoreData.toString());
      return  right([]);
    
    }
    Query query = firestore.collection(FirebaseCollection.users).orderBy("age", descending: false);
  
    try {
      if (selectAge == 1) {
        query = query.where("age", isGreaterThanOrEqualTo: 50);
      } else if (selectAge == 2) {
        query = query.where("age", isLessThanOrEqualTo: 50);
      }
      if (search != null && search.isNotEmpty ) {
        query = query.where("search", arrayContains: search.toLowerCase());
      }
      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc!);
      }
          // log(query.toString());
      QuerySnapshot snapshotlimit = await query.limit(10).get();
      
      if(snapshotlimit.docs.isNotEmpty){
       lastDoc= snapshotlimit.docs.last;
      }

      if (snapshotlimit.docs.length < 10) {
        noMoreData = true;

      }
        final userData = snapshotlimit.docs
            .map((doc) => Usermodel.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
  
      //  allUsers.addAll(userData);
      return right(userData);
    
      
      
    }catch (e){
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  
  }
  
  @override
  void clearData() {
  lastDoc=null;
  noMoreData=false;
  } 
  
}