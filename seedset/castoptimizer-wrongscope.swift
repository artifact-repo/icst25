// REQUIRES: optimized_stdlib

// RUN: %target-swift-frontend -emit-sil -o /dev/null \
// RUN:   %s -Xllvm -sil-print-debuginfo -Onone -sil-verify-all \
// RUN:   -Xllvm -sil-print-after=diagnostic-constant-propagation \
// RUN:   2>&1 | %FileCheck %s

// CHECK: alloc_stack $any R, loc {{.*}}, scope [[SCOPE:[0-9]+]]
// CHECK-NEXT: init_existential_addr {{.*}} : $*any R, $Float, loc {{.*}}, scope [[SCOPE]]
// CHECK-NEXT: copy_addr [take] %8 to [init] {{.*}} : $*Float, loc {{.*}}, scope [[SCOPE]]

protocol R {}
extension Float: R {}
print(1.0 as Float? as! R)
