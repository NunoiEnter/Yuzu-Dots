{ pkgs ? import <nixpkgs> {} }:

let
  # ดึง path ของ pthreads ออกมาเก็บไว้ในตัวแปร เพื่อให้อ้างอิงง่ายๆ
  mingw_pthreads = pkgs.pkgsCross.mingwW64.windows.pthreads;
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    rustup
    pkgsCross.mingwW64.stdenv.cc
    mingw_pthreads
  ];

  shellHook = ''
    # 1. บอก Rust ว่า Linker ชื่ออะไร (เหมือนเดิม)
    export CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER=x86_64-w64-mingw32-gcc

    # 2. [สำคัญ] บอก Rust ว่าให้ไปหา library (พวก .a) ที่โฟลเดอร์ lib ของ pthreads
    export RUSTFLAGS="-L native=${mingw_pthreads}/lib"

    echo "------------------------------------------------"
    echo "🚀 Ready for Windows Cross-compile!"
    echo "🔧 Linker Fix Applied: pointing to ${mingw_pthreads}/lib"
    echo "------------------------------------------------"
  '';
}
