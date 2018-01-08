import 'package:bignum/bignum.dart';

void main() {
  BigInteger x = new BigInteger(
      0x47173285a8d7341e5e972fc677286384f802f8ef42a5ec5f03bbfa254cb01fad);
  print("0x47173285a8d7341e5e972fc677286384f802f8ef42a5ec5f03bbfa254cb01fad");
  print("0x${x.toString(16)}");
}
