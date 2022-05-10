@echo off

DEL  "web\worker.dart.js"
DEL  "web\worker.dart.min.js"
flutter "pub" "run" "build_runner" "build" "--delete-conflicting-outputs" "-o" "web:build\web\"
COPY  "build\web\worker.dart.js" "web\worker.dart.js"
DEL /S "build\web"
flutter "pub" "run" "build_runner" "build" "--release" "--delete-conflicting-outputs" "-o" "web:build\web\"
COPY  "build\web\worker.dart.js" "web\worker.dart.min.js"
DEL /S "build\web"