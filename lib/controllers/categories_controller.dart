import 'package:ecommerce_app/models/categories_model.dart';
import 'package:ecommerce_app/services/categories_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesControllerProvider = StateNotifierProvider<CategoriesController, bool> ((ref){
  final categoriesServices = ref.watch(categoriesServiceProvider);

  return CategoriesController(categoryService: categoriesServices, ref: ref);
});

final getsProductsProvider = StreamProvider((ref){
  final categoriesController = ref.watch(categoriesControllerProvider.notifier);
  categoriesController.getCategories();
});

class CategoriesController extends StateNotifier<bool> {
  final CategoriesServices _categoryService;
  final Ref _ref;

  CategoriesController(
      {required CategoriesServices categoryService, required Ref ref})
      : _categoryService = categoryService,
        _ref = ref,super(false);

        Stream<List<Categories>> getCategories(){
          return _categoryService.getCategories();
        }
}
