import 'package:gamapath/model/CategoriesModel.dart';
import 'package:gamapath/provider/categories_provider.dart';

class CategoriesRepository{
  final _categoriesProvider = CategoriesProvider();

  Future<List<CategoriesItem>> getCategories(){
    return _categoriesProvider.getCategories();
  }
}

class CategoriesNetworkError extends Error{}