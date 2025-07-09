import '../models/favorite_item_model.dart';

class FavouriteRepository {

  Future <List<FavouriteItemModel>> fetchItem() async{
   await Future.delayed(const Duration(seconds:3));
   return List.of(_generatedList (10));

}

List <FavouriteItemModel> _generatedList (int length){
    return List.generate(length, (index) => FavouriteItemModel(id: index.toString(), value: 'Item $index'));
}  
}