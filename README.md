# 🧪 C++ Test Generator with Code Coverage and GitHub Actions CI/CD

This project demonstrates a complete automated workflow for:

- Writing and organizing C++ code
- Generating GoogleTest-based unit tests
- Measuring code coverage with `gcov` and `gcovr`
- Automating builds and coverage reporting using GitHub Actions

---

## 📁 Project Structure

```
cpp-test-generator/
├── input-code/ # Source C++ files to be tested
│ └── add.cpp
├── include/ # Header files
│ └── add.h
├── tests/ # GoogleTest unit tests
│ └── test_add.cpp
├── yaml-instructions/ # AI/test generator instructions (YAML)
├── .github/workflows/ # GitHub Actions CI/CD workflows
│ └── ci.yml
├── build/ # Auto-generated build and coverage results (ignored in git)
├── run.sh # Bash script to automate test + coverage (Linux)
├── run.bat # Batch file to automate test + coverage (Windows)
├── CMakeLists.txt # CMake project configuration
└── README.md # This file
```

---

## 🔧 Requirements

Install the following tools before starting:

### 🖥️ Windows

- [CMake](https://cmake.org/download/)
- [MinGW](https://sourceforge.net/projects/mingw/)
- [Python](https://www.python.org/downloads/) (`>=3.10`)
- `gcovr` via pip:

  ```bash
  pip install gcovr
  ```

Ensure g++, cmake, and gcovr are all accessible from your terminal (i.e., added to PATH).

### 🚀 How to Run Locally
#### ✅ Step-by-Step Instructions (Windows)
### 1. Clone the repository

```bash
git clone https://github.com/anthony-rozario/cpp-test-generator.git
cd cpp-test-generator
```
### 2. Run the full build and test pipeline

You can run the automated batch script instead of running commands manually:

```bash
run.bat
```

What it does:
- Cleans any previous build
- Re-runs cmake with coverage flags
- Builds using mingw32-make
- Executes tests using GoogleTest
- Generates coverage reports (HTML and CLI)

### 3. View Coverage Report
After successful execution, open the file:

```bash
build/coverage.html
```

This will show a full breakdown of which lines and functions were covered during tests.

### 🧪 Example Code Tested
``` add.cpp (inside input-code/)```
```cpp

#include "add.h"

long long add(long long a, long long b) {
    return a + b;
}
test_add.cpp (inside tests/)
cpp
Copy
Edit
#include <gtest/gtest.h>
#include "add.h"

TEST(AddTest, AddsTwoNumbers) {
    EXPECT_EQ(add(2, 3), 5);
}

TEST(AddTest, HandlesNegativeNumbers) {
    EXPECT_EQ(add(-2, -5), -7);
}

TEST(AddTest, HandlesLargeNumbers) {
    EXPECT_EQ(add(1e9, 1e9), 2e9);
}

TEST(AddTest, HandlesWrappedAroundNumbers) {
    EXPECT_EQ(add(LLONG_MAX, 0), LLONG_MAX);
}
```

### 🤖 GitHub Actions CI/CD

This repo uses GitHub Actions to:
- Run tests automatically on each push
- Generate a coverage report on the GitHub runner
- Confirm that tests always pass before merging code

CI File: .github/workflows/ci.yml

```yaml
name: C++ Tests and Coverage

on: [push, pull_request]

jobs:
  build-test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Install dependencies
        run: |
          sudo apt update
          sudo apt install -y g++ cmake lcov python3-pip
          pip install gcovr

      - name: Configure and build
        run: |
          cmake -DCMAKE_CXX_FLAGS="--coverage" -B build
          cmake --build build

      - name: Run tests
        run: |
          cd build
          ./main_test

      - name: Generate coverage report
        run: |
          cd build
          gcovr -r .. > coverage.txt
          gcovr -r .. --html --html-details -o coverage.html

      - name: Upload coverage report
        uses: actions/upload-artifact@v3
        with:
          name: code-coverage-report
          path: build/coverage.html

```

### 🔁 Re-run Tests Locally (Manual)
```bash
# Clean old build
rd /s /q build

# Reconfigure CMake
cmake -G "MinGW Makefiles" -DCMAKE_CXX_COMPILER=g++ -DCMAKE_CXX_FLAGS="--coverage" -B build
cd build

# Build using mingw32-make
mingw32-make

# Run test binary
main_test.exe

# Generate coverage
gcovr -r .. > coverage.txt
gcovr -r .. --html --html-details -o coverage.html
```

### 📊 Sample Coverage Output
- 100% Line coverage for add.cpp
- 100% Line + Function coverage for test files
- Branch coverage depends on logic complexity

(if available)

### 🧠 Summary

This repo serves as a complete boilerplate/template for any C++ project requiring:
- Structured source/test layout
- Unit testing with GoogleTest
- Coverage reporting using gcov + gcovr
- CI automation with GitHub Actions

## 📌 Notes

- `.gcda` and `.gcno` files are automatically handled when using `--coverage` flag.
- `gcovr` makes the process portable across platforms.
- You can test multiple `.cpp` files by placing them in `input-code/` and adding appropriate tests.

---

### 📬 Feedback & Contributions
Feel free to fork, improve, and submit pull requests. Let's make C++ testing easier for everyone 🚀

## 🛠 Maintainer

**Anthony Prakash Rozario**  
🎓 MCA, KIIT University  
🔗 [LinkedIn](https://www.linkedin.com/in/anthony-rozario) | [GitHub](https://github.com/anthony-rozario)

## 📃 License

MIT License.