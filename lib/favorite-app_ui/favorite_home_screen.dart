
import 'package:favorite_app_using_bloc_state_managment/favorite_app_state/favorite_app_bloc.dart';
import 'package:favorite_app_using_bloc_state_managment/favorite_app_state/favorite_app_event.dart';
import 'package:favorite_app_using_bloc_state_managment/favorite_app_state/favorite_app_state.dart';
import 'package:favorite_app_using_bloc_state_managment/models/favorite_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _homeScreenState();

}

class _homeScreenState extends State<HomeScreen>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FavoriteAppBloc>().add(FetchFavouriteList());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite App'),
        actions: [
          BlocBuilder<FavoriteAppBloc, FavouriteItemStates>(
      builder: (context , state) {
        return Visibility(
          visible: state.temFavouriteitemList.isNotEmpty ? true : false,
          child: IconButton(
              onPressed: () {
                context.read<FavoriteAppBloc>().add(DeleteItem());
              }, icon: Icon(Icons.delete), color: Colors.red),
        );
      },
          ),
        ],
        centerTitle: true,
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder <FavoriteAppBloc , FavouriteItemStates>(
          builder: (context , state){
            switch(state.listStatus){
              case ListStatus.loading:
                return Center(child: const CircularProgressIndicator());
              case ListStatus.failure:
                return Text('something went wrong');
              case ListStatus.success:

                return ListView.builder(

                    itemCount: state.favouriteitemList.length,
                    itemBuilder:(context, index) {
                      final item = state.favouriteitemList[index];
                      return Card(
                        child: ListTile(
                          leading:Checkbox(
                              value: state.temFavouriteitemList.contains(item)? true : false , onChanged: (value){
                             if(value!){
                               context.read<FavoriteAppBloc>().add(SelectItem(item: item));
                             }else{
                               context.read<FavoriteAppBloc>().add(UnSelectItem(item: item));
                             }
                          }),
                          title:Text(item.value.toString()),
                          trailing: IconButton(onPressed:(){
                            FavouriteItemModel itemModel= FavouriteItemModel(id:item.id, value:item.value,
                            isFavourite: item.isFavourite ? false :true
                            );
                            context.read<FavoriteAppBloc>().add(FavouriteItem(item:itemModel));
                          }, icon:Icon(
                              item.isFavourite ? Icons.favorite :Icons.favorite_outline
                          )),
                        ),

                      );
                    });
            }

          },
        ),
      )
    );
  }

}