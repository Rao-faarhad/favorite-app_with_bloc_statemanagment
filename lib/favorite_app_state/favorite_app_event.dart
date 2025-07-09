import 'package:equatable/equatable.dart';

import '../models/favorite_item_model.dart';

//abstract class is a base classs which provide interface for other class
abstract class FavouriteEvent extends Equatable{
  const FavouriteEvent();
  @override
  List <Object> get props => [];
}

class FetchFavouriteList extends FavouriteEvent {}

class FavouriteItem extends FavouriteEvent {
  final FavouriteItemModel item;
  const FavouriteItem({required this.item});
}
class SelectItem extends FavouriteEvent {
  final FavouriteItemModel item;
  const SelectItem({required this.item});
}
class UnSelectItem extends FavouriteEvent {
  final FavouriteItemModel item;
  const UnSelectItem({required this.item});
}

class DeleteItem extends FavouriteEvent {
}
