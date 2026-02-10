import 'package:ecommerce_app/services/address_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shipping_model.dart';

/// Stream provider for real-time address updates
final addressStreamProvider = StreamProvider<List<ShippingAddress>>((ref) {
  final addressServices = ref.watch(addressServicesProvider);
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return Stream.value([]);
  }
  return addressServices.getShippingAddress(user.uid);
});

/// Provider for selected address in shipping screen
final selectedAddressProvider = StateProvider<ShippingAddress?>((ref) => null);

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
Future<void> deleteShippingAddress(String addressId ) async{
  await _addressServices.deleteShippingAddress(addressId);
}

}