import 'package:flutter_test/flutter_test.dart';
void main(){
  test("This is a test", (){
    int a = 1;
    expect(a, 1);
    a += 1;
    expect(a, 2);
  });
}
