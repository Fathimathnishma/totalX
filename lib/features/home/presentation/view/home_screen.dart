
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxtestapp/features/home/presentation/provider/provider.dart';

import 'package:totalxtestapp/features/home/presentation/view/widgets/custom_dialog.dart';
import 'package:totalxtestapp/general/utils/app_colors.dart';
import 'package:totalxtestapp/main.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}





class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController =ScrollController();
// final SearchController _searchController =SearchController();
 


  @override
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      final addProvider = Provider.of<MainProvider>(context, listen: false);
      //addProvider.getData();
      addProvider.clearData();
      addProvider.searchController.addListener(() {
      addProvider.clearData();
       addProvider.initData(scrollController: _scrollController);
      });
     addProvider.initData(scrollController: _scrollController, );
      
     });
    super.initState();
   void dispose(){
      _scrollController.dispose();
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, stateTaskAdd, child) => Scaffold(
        backgroundColor: Colorconst.primaryColor.withOpacity(0.7),
        appBar: AppBar(
          title:  const Text(
            "Users",
            style: TextStyle(color: Colors.white),
          ),
        
          actions: [
            SizedBox(
              height: height * 0.05,
              width: width * 0.70,
              child: CupertinoSearchTextField( 
                style: const TextStyle(color:  Colorconst.whiteColor),
                itemColor: Colorconst.whiteColor,
                  controller: stateTaskAdd.searchController,
                  backgroundColor: Colorconst.whiteColor.withOpacity(0.1)),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: height * 0.2,
                      width: width * 1,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 0,
                                groupValue: stateTaskAdd.selectAgeCategory,
                                onChanged: (value) {
                                  stateTaskAdd.updateFilter(
                                      scrollController: _scrollController,
                                      agevalue: value ?? 0, );
                                  Navigator.pop(context);

                                  // context.read()<TaskAdd>().getData(context);
                                },
                              ),
                              const Text("All")
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: stateTaskAdd.selectAgeCategory,
                                onChanged: (value) {
                                  stateTaskAdd.updateFilter(
                                      scrollController: _scrollController,
                                      agevalue: value ?? 1);
                                  Navigator.pop(context);
                                },
                              ),
                              const Text("above 50")
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue: stateTaskAdd.selectAgeCategory,
                                onChanged: (value) {
                                  stateTaskAdd.updateFilter(
                                      scrollController: _scrollController,
                                      agevalue: value ?? 2);

                                  Navigator.pop(context);
                                },
                              ),
                              const Text("below 50")
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Icon(
                Icons.filter_list_rounded,
                color: Colorconst.whiteColor,
              ),
            ),
            SizedBox(
              width: width * 0.02,
            )
          ],
          backgroundColor: Colorconst.primaryColor.withOpacity(0.5),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomDialogWid(),
                ));
          },
          backgroundColor: Colorconst.primaryColor.withOpacity(0.4),
          child: const Icon(
            Icons.add,
            color: Colorconst.whiteColor,
          ),
        ),
        body: stateTaskAdd.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : (stateTaskAdd.isLoading && stateTaskAdd.allUsers.isEmpty)
                ? const Center(child: Text("no data",style: TextStyle(color: Colorconst.whiteColor),))
                : ListView.separated(
                  controller: _scrollController, 
                    itemCount: stateTaskAdd.allUsers.length  + (stateTaskAdd.noMoreData ? 0 : 1),
                  itemBuilder: (BuildContext context, int index) {
                     if (index == stateTaskAdd.allUsers.length ) {
                      return 
                         const Center(child: CircularProgressIndicator(color: Colorconst.whiteColor,));
                      }
                      return ListTile(
                      title: Text(
                        stateTaskAdd.allUsers[index].name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(stateTaskAdd.allUsers[index].age.toString(),style: const TextStyle(color:Colorconst.whiteColor),),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      color: Colors.white,
                    );
                  },
                ),
      ),
    );
  }
}
