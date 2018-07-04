// Copyright (c) 2018, the Dart Team. All rights reserved. Use of this
// source code is governed by a BSD-style license that can be found in
// the LICENSE file.

// Try out some reflective invocations.
// Build with `cd ..; pub run build_runner build example`.

import 'package:reflectable/reflectable.dart';
import 'reflectable_test.reflectable.dart';

class MyReflectable extends Reflectable {
  const MyReflectable() : super(invokingCapability);
}

const myReflectable = const MyReflectable();

@myReflectable
class A {
  int arg0() => 42;
  int arg1(int x) => x - 42;
  int arg1to3(int x, int y, [int z = 0, w]) => x + y + z * 42;
  int argNamed(int x, int y, {int z: 42}) => x + y - z;
  int operator +(x) => 42 + x;
  int operator [](x) => 42 + x;
  void operator []=(x, v) { f = x + v; }
  int operator -() => -f;
  int operator ~() => f + 2;

  int f = 0;

  static int noArguments() => 42;
  static int oneArgument(x) => x - 42;
  static int optionalArguments(x, y, [z = 0, w]) => x + y + z * 42;
  static int namedArguments(int x, int y, {int z: 42}) => x + y - z;
}

String doReflect() {
  // The program execution must start run this initialization before
  // any reflective features can be used.
  initializeReflectable();

  List<String> result = [];

  // Get hold of a few mirrors.
  A instance = new A();
  InstanceMirror instanceMirror = myReflectable.reflect(instance);
  ClassMirror classMirror = myReflectable.reflectType(A);

  // Invocations of methods accepting positional arguments (printing '42').
  result.add(instanceMirror.invoke("arg0", []));
  result.add(instanceMirror.invoke("arg1", [84]));
  result.add(instanceMirror.invoke("arg1to3", [40, 2]));
  result.add(instanceMirror.invoke("arg1to3", [1, -1, 1]));
  result.add(instanceMirror.invoke("arg1to3", [21, 21, 0, "foo"]));

  // Invocations of methods accepting named arguments (result.adding '42').
  result.add(instanceMirror.invoke("argNamed", [55, 29]));
  result.add(instanceMirror.invoke("argNamed", [21, 21], {#z: 0}));

  // Invocations of operators.
  result.add(instanceMirror.invoke("+", [42])); // '84'.
  result.add(instanceMirror.invoke("[]", [42])); // '84'.
  instanceMirror.invoke("[]=", [1, 2]);
  result.add(instance.f); // '3'.
  result.add(instanceMirror.invoke("unary-", [])); // '-3'.
  result.add(instanceMirror.invoke("~", [])); // '5'.

  // Similar invocations on static methods (result.adding '42').
  result.add(classMirror.invoke("noArguments", []));
  result.add(classMirror.invoke("oneArgument", [84]));
  result.add(classMirror.invoke("optionalArguments", [40, 2]));
  result.add(classMirror.invoke("optionalArguments", [1, -1, 1]));
  result.add(classMirror.invoke("optionalArguments", [21, 21, 0, "foo"]));
  result.add(classMirror.invoke("namedArguments", [55, 29]));
  result.add(classMirror.invoke("namedArguments", [21, 21], {#z: 0}));
  return result.toString();
}
