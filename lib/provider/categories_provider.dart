import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamapath/model/CategoriesModel.dart';

class CategoriesProvider{
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  static String mainUrl = "https://gamapath.fk-kmk.id/api";

  Future<List<CategoriesItem>> getCategories() async{
    String userToken = await storage.read(key: 'token');
    var categoriesUrl = '$mainUrl/categories';
    try{
      _dio.options.headers["Authorization"] = 'Bearer $userToken';
      Response response = await _dio.get(categoriesUrl);
      print('Categories URL :  $categoriesUrl');
      print("User Token : $userToken");
      print("data ${response.data}");
      List<CategoriesItem> categories = CategoriesModel.fromJson(response.data).data;
      return categories;
    }catch(error, stacktrace){
      print(
      "Exception occured: $error stackTrace: $stacktrace token : $userToken");
    return <CategoriesItem>[];
    }
  }
}