
# 🧪 C++ Unit Test Generator using LLM + GoogleTest

This project automates the generation of **GoogleTest-based unit tests** for C++ functions using a **local LLM model (CodeLlama via Ollama)** and tools like `CMake`, `MinGW`, and `gcov` for building and analyzing test coverage.

---

## 📦 Features

- Generates GoogleTest-compatible unit test files using LLM
- Supports real-time prompt customization via YAML
- Compiles and runs unit tests using CMake & MinGW
- Displays detailed test results via GoogleTest
- Collects and displays code coverage using `gcov`

---

## 🚀 Prerequisites

Ensure the following tools are installed:

| Tool          | Version / Notes |
|---------------|-----------------|
| [Python](https://python.org) | ≥ 3.10 |
| [Git](https://git-scm.com) | any |
| [CMake](https://cmake.org) | ≥ 3.25 |
| [MinGW](https://www.mingw-w64.org/) | with g++ |
| [Ollama](https://ollama.com/) | installed and running |
| GoogleTest | auto-downloaded via FetchContent |

---

## 🔧 Setup

### 1. Clone the Repository

```bash
git clone https://github.com/anthony-rozario/cpp-test-generator.git
cd cpp-test-generator
```

---

### 2. Set Up Ollama with CodeLlama

Ensure Ollama is running and pull the `codellama` model:

```bash
ollama run codellama
```

> You should see `>>>` prompt confirming the model is running.

---

## 🧠 Usage

### Step 1: Add Your C++ Code

Put your implementation in:

```
input-code/add.cpp
input-code/add.h
```

Example `add.cpp`:

```cpp
int add(int a, int b) {
    return a + b;
}
```

And `add.h`:

```cpp
int add(int a, int b);
```

---

### Step 2: Customize LLM Instructions (Optional)

Edit `yaml-instructions/instructions.yaml` to control how the unit tests are generated (e.g., require edge cases, style preferences, etc.).

---

### Step 3: Generate Unit Tests Using Python Script

```bash
python main.py
```

This script:
- Loads your implementation
- Sends it to the LLM
- Writes test cases to `tests/test_add.cpp`

---

### Step 4: Build the Project with Code Coverage

```bash
cmake -G "MinGW Makefiles" -DCMAKE_CXX_COMPILER=g++ -DCMAKE_CXX_FLAGS="--coverage" -B build
cd build
mingw32-make
```

---

### Step 5: Run Unit Tests

```bash
./main_test.exe
```

You should see output like:

```
[==========] Running 4 tests from 1 test suite.
[----------] 4 tests from AddTest
[ RUN      ] AddTest.AddsTwoNumbers
[       OK ] AddTest.AddsTwoNumbers (0 ms)
...
[  PASSED  ] 4 tests.
```

---

### Step 6: Generate Coverage Report

```bash
gcov ../input-code/add.cpp -o CMakeFiles/main_test.dir/input-code
```

Expected output:

```
File 'add.cpp'
Lines executed:100.00% of 4
Creating 'add.cpp.gcov'
```

You’ll get a `.gcov` file showing which lines were covered by tests.

---

## 📁 Project Structure

```
cpp-test-generator/
│
├── input-code/              # Your C++ implementation
│   ├── add.cpp
│   └── add.h
│
├── tests/                   # Auto-generated GoogleTest tests
│   └── test_add.cpp
│
├── yaml-instructions/       # Optional YAML prompt for LLM
│   └── instructions.yaml
│
├── main.py                  # Python script for test generation
├── CMakeLists.txt
└── build/                   # Build artifacts
```

---

## ✅ Example Generated Test

```cpp
#include <gtest/gtest.h>
#include "add.h"

TEST(AddTest, AddsTwoNumbers) {
  EXPECT_EQ(add(2, 3), 5);
}

TEST(AddTest, HandlesNegativeNumbers) {
  EXPECT_EQ(add(-1, -2), -3);
}

TEST(AddTest, HandlesLargeNumbers) {
  EXPECT_EQ(add(INT_MAX, 0), INT_MAX);
}
```

---

## 🧽 Clean Up

To reset the build and test results:

```bash
rd /s /q build
```

Then rebuild:

```bash
cmake -G "MinGW Makefiles" -DCMAKE_CXX_COMPILER=g++ -DCMAKE_CXX_FLAGS="--coverage" -B build
cd build
mingw32-make
```

---

## 💡 Future Improvements

- Support for more compilers and platforms
- Generate mocks for dependencies
- Generate CTest-compatible results
- Web UI for prompt & test generation

---

## 🛠 Maintainer

**Anthony Prakash Rozario**  
🎓 MCA, KIIT University  
🔗 [LinkedIn](https://www.linkedin.com/in/anthony-rozario) | [GitHub](https://github.com/anthony-rozario)

---

## 📝 License

MIT License
