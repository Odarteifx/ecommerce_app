import 'package:ecommerce_app/models/product_models.dart';
import 'package:ecommerce_app/services/product_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productControlProvider = StateNotifierProvider<ProductController, bool>((ref){
  final productService = ref.watch(prodcutServiceProvider);
  return ProductController(productService: productService, ref: ref);
});

final getProductsbyCategoryProvider = StreamProvider.family((ref, String categoryname){
  return ref.watch(productControlProvider.notifier).getProductsbyCategoryName(categoryname);
});

final getsProductsProvider = StreamProvider((ref){
  return ref.watch(productControlProvider.notifier).getProducts();
});

class ProductController extends StateNotifier<bool> {
  final ProductServices _productService;
  final Ref _ref;

  ProductController({required ProductServices productService, required Ref ref})
      : _productService = productService,
        _ref = ref,
        super(false);

        Stream<List<ProductModel>> getProducts(){
          return _productService.getProducts();
        }

        Stream<ProductModel> getProductbyId(String productId){
          return _productService.getProductId(productId);
        }

        Stream<List<ProductModel>> getProductsbyCategoryName(String categoryname){
          return _productService.getProductsbyCategory(categoryname);
        }
}
