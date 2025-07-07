@echo off
setlocal enabledelayedexpansion

REM === Step 1: Clean previous build ===
echo [INFO] Cleaning previous build...
rmdir /s /q build

REM === Step 2: Configure the project ===
echo [INFO] Configuring project with CMake...
cmake -G "MinGW Makefiles" -DCMAKE_CXX_COMPILER=g++ -DCMAKE_CXX_FLAGS="--coverage" -B build

REM === Step 3: Build the project ===
echo [INFO] Building project...
cd build
mingw32-make || exit /b

REM === Step 4: Run the tests ===
echo [INFO] Running tests...
main_test.exe || exit /b

REM === Step 5: Generate code coverage report ===
echo [INFO] Generating code coverage report...
gcovr -r .. --exclude '.*_deps/.*' --exclude '.*CMakeFiles.*' > coverage.txt
gcovr -r .. --exclude '.*_deps/.*' --exclude '.*CMakeFiles.*' --html --html-details -o coverage.html

REM === Step 6: Open the HTML report ===
echo [INFO] Opening HTML report...
start coverage.html

cd ..
echo [SUCCESS] All tasks completed.
pause
