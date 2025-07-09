import 'package:equatable/equatable.dart';
import 'package:favorite_app_using_bloc_state_managment/models/favorite_item_model.dart';


enum ListStatus {loading, success, failure}
class FavouriteItemStates extends Equatable {
  final List<FavouriteItemModel> favouriteitemList;
  final List<FavouriteItemModel> temFavouriteitemList;
  final ListStatus listStatus;

  const FavouriteItemStates({
    this.favouriteitemList = const [],
    this.temFavouriteitemList = const [],
    this.listStatus = ListStatus.loading
  });

  FavouriteItemStates copyWith({List<FavouriteItemModel> ? favouriteitemList,List<FavouriteItemModel> ? temFavouriteitemList , ListStatus? listStatus}){
    return FavouriteItemStates(
    favouriteitemList: favouriteitemList ?? this.favouriteitemList,
        temFavouriteitemList: temFavouriteitemList ?? this.temFavouriteitemList,
     listStatus : listStatus ?? this.listStatus
    );
  }

  @override
  List<Object> get props => [favouriteitemList, listStatus , temFavouriteitemList];

}
