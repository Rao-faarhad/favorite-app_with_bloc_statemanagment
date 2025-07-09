import 'package:bloc/bloc.dart';
import 'package:favorite_app_using_bloc_state_managment/favorite_app_state/favorite_app_event.dart';
import 'package:favorite_app_using_bloc_state_managment/favorite_app_state/favorite_app_state.dart';
import 'package:favorite_app_using_bloc_state_managment/repository/favorite_repo.dart';
import 'package:meta/meta.dart';

import '../models/favorite_item_model.dart';
//
// class FavoriteAppBloc extends Bloc<FavouriteEvent, FavouriteItemStates> {
//
//   //now we know we return List so
//   List<FavouriteItemModel> favouriteList = [];
//   List<FavouriteItemModel> temFavouriteitemList = [];
//   //favorite repository use as dependency injection
//   FavouriteRepository favouriteRepository;
//
//   FavoriteAppBloc(this.favouriteRepository) : super(FavouriteItemStates()) {
//     on<FetchFavouriteList>(fetchList);
//     on<FavouriteItem>(_addFavouriteItem);
//     on<SelectItem>(_selectItem);
//     on<UnSelectItem>(_unSelectItem);

//   }
//     void fetchList(FetchFavouriteList event , Emitter<FavouriteItemStates> emit) async{
//       //this data comes from repository
//       favouriteList = await favouriteRepository.fetchItem();
//       emit(state.copyWith(favouriteitemList:List.from(favouriteList) , listStatus:ListStatus.success ));
//     }
//
//   void _addFavouriteItem(FavouriteItem event , Emitter<FavouriteItemStates> emit) async{
//     //this data comes from repository
//  final index = favouriteList.indexWhere((element) => element.id == event.item.id);
//  favouriteList[index] = event.item;
//  emit(state.copyWith(favouriteitemList:List.from(favouriteList)));
//   }
//
//   void _selectItem(SelectItem event , Emitter<FavouriteItemStates> emit) async{
//     temFavouriteitemList.add(event.item);
//     emit(state.copyWith(favouriteitemList:List.from(favouriteList)));
//   }
//   //
//   // void _unSelectItem(UnSelectItem event , Emitter<FavouriteItemStates> emit) async{
//   //   temFavouriteitemList.remove(event.item);
//   //   emit(state.copyWith(favouriteitemList:List.from(favouriteList)));
//   // }
//   void _unSelectItem(UnSelectItem event , Emitter<FavouriteItemStates> emit) async {
//     temFavouriteitemList.removeWhere((element) => element.id == event.item.id);
//     emit(state.copyWith(
//       favouriteitemList: List.from(favouriteList),
//       temFavouriteitemList: List.from(temFavouriteitemList), // 👈 same here
//     ));
//   }
//
//
// }

class FavoriteAppBloc extends Bloc<FavouriteEvent, FavouriteItemStates> {
  List<FavouriteItemModel> favouriteList = [];
  List<FavouriteItemModel> temFavouriteitemList = [];
  final FavouriteRepository favouriteRepository;

  FavoriteAppBloc(this.favouriteRepository) : super(FavouriteItemStates()) {
    on<FetchFavouriteList>(_fetchList);
    on<FavouriteItem>(_addFavouriteItem);
    on<SelectItem>(_selectItem);
    on<UnSelectItem>(_unSelectItem);
    on<DeleteItem>(_deleteItem);
  }

  void _fetchList(FetchFavouriteList event, Emitter<FavouriteItemStates> emit) async {
    favouriteList = await favouriteRepository.fetchItem();
    emit(state.copyWith(
      favouriteitemList: List.from(favouriteList),
      listStatus: ListStatus.success,
    ));
  }

  void _addFavouriteItem(FavouriteItem event, Emitter<FavouriteItemStates> emit) {
    final index = favouriteList.indexWhere((element) => element.id == event.item.id);
    if (index != -1) {
      favouriteList[index] = event.item;
    }
    emit(state.copyWith(favouriteitemList: List.from(favouriteList)));
  }

  void _selectItem(SelectItem event, Emitter<FavouriteItemStates> emit) {
    // Add the selected item to temp list
    final updatedTempList = List<FavouriteItemModel>.from(state.temFavouriteitemList)
      ..add(event.item);

    emit(state.copyWith(
      temFavouriteitemList: updatedTempList,
      favouriteitemList: List.from(favouriteList),
    ));
  }

  void _unSelectItem(UnSelectItem event, Emitter<FavouriteItemStates> emit) {
    // Remove the unselected item from temp list
    final updatedTempList = List<FavouriteItemModel>.from(state.temFavouriteitemList)
      ..removeWhere((e) => e.id == event.item.id);

    emit(state.copyWith(
      temFavouriteitemList: updatedTempList,
      favouriteitemList: List.from(favouriteList),
    ));
  }

  void _deleteItem(DeleteItem event, Emitter <FavouriteItemStates> emit) async{
    for(int i =0; i < temFavouriteitemList.length; i++){
      favouriteList.remove(temFavouriteitemList[i]);
    }
    temFavouriteitemList.clear();
    emit(state.copyWith(
      favouriteitemList: List.from(favouriteList),
        temFavouriteitemList: List.from(temFavouriteitemList)
    ));
  }



}

