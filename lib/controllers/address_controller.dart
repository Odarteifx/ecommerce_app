import 'package:ecommerce_app/services/address_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shipping_model.dart';

final addressControllerProvider = StateNotifierProvider<AddressController, List<ShippingAddress>>((ref){
  final addressServices = ref.watch(addressServicesProvider);
  
  return AddressController(addressServices);
});

class AddressController extends StateNotifier<List<ShippingAddress>> {
  final AddressServices _addressServices;

  AddressController(this._addressServices) : super([]){
    _fetchShippingAddresses();
  }
  


  Future<void> _fetchShippingAddresses() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      _addressServices.getShippingAddress(userId).listen((addresses){
        state = addresses;
      });
      
    }
  }

  Future<void> addShippingAddress(ShippingAddress address) async {
      await _addressServices.addShippingAddress(address);
  }


}