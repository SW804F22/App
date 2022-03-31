import 'package:flutter_test/flutter_test.dart';
import 'package:poirecapi/login/models/username.dart';

void main(){
  test("Some test", (){
    final Username test = Username.dirty("test");
    expect(test.value, 'test');
  }
  );
}
