cmake_minimum_required(VERSION 3.14)
project(cpp-test-generator)

# ✅ Enforce MSVC runtime globally
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebugDLL")

# 📦 GoogleTest via FetchContent
include(FetchContent)

FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/release-1.12.1.zip
)

# 🔧 Apply runtime fix to GoogleTest before building
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(googletest)

# ✅ Add include directory for your code
include_directories(${PROJECT_SOURCE_DIR}/input-code)

# 🧪 Test binary
add_executable(main_test tests/test_add.cpp input-code/add.cpp)
target_link_libraries(main_test gtest_main)

enable_testing()
include(GoogleTest)
gtest_discover_tests(main_test)
