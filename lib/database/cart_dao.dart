import 'package:floor/floor.dart';
import 'package:products/models/cart_model.dart';

@dao
abstract class CartDao {
  @Query('SELECT * FROM CartModel')
  Future<List<CartModel>> findAllCart();

  @Query('SELECT * FROM CartModel WHERE id = :id')
  Future<CartModel?> findCartById(int id);
  @Query('DELETE FROM CartModel')
  Future<void> deleteAll();

  @Query('DELETE FROM CartModel WHERE id = :id')
  Future<void> deleteById(int id);

  @insert
  Future<void> insertCart(CartModel cart);

  @delete
  Future<void> deleteCart(CartModel cart);
  @update
  Future<void> updateCart(CartModel cart);
}
