import requests
import os

SOURCE_FILE = "input-code/add.cpp"
TEST_FILE = "tests/test_add.cpp"
MODEL = "codellama"
OLLAMA_URL = "http://localhost:11434/api/generate"

# Load C++ code
with open(SOURCE_FILE, "r") as f:
    cpp_code = f.read()

# Optional: Load YAML prompt
if os.path.exists("prompts/instructions.yaml"):
    with open("prompts/instructions.yaml", "r") as f:
        instructions = f.read()
else:
    instructions = ""

# Create prompt
prompt = f"""{instructions}
You are given some C++ unit tests written for GoogleTest.

Generate unit tests for the following C++ function using the Google Test framework.

Requirements:
- Output ONLY the final C++ test code
- The code must include all required headers (e.g., #include <gtest/gtest.h>)
- No comments, explanations, or markdown
- Format the code properly
- Ensure the test functions follow GoogleTest structure
- Make sure function calls (like `add`) exist and have correct signature
- The tests should be comprehensive and cover various edge cases
- The tests should be compatible with GoogleTest framework
- The output code should be formatted properly, no extra comments or explanations, only give the code, nothing else should be present
- The output should be a single refined test file compatible with GoogleTest framework
- The output should not have any duplicate tests
- The output should not have any ```cpp``` or similar formatting
- The output should start with `#includes` and end with code, not formatting like ```cpp``` or ```
- Only include the tests, not the implementation
- The output format should be like this:


#include <gtest/gtest.h>
#include "add.h"

TEST(AddTest, AddsTwoNumbers) {{
  EXPECT_EQ(add(2, 3), 5);
}}

TEST(AddTest, HandlesNegativeNumbers) {{
  EXPECT_EQ(add(-1, -2), -3);
}}

TEST(AddTest, HandlesLargeNumbers) {{
  EXPECT_EQ(add(INT_MAX, INT_MAX), (int)(2 * INT_MAX - 1));
}}

TEST(AddTest, HandlesWrappedAroundNumbers) {{
  EXPECT_EQ(add(INT_MIN, INT_MIN), INT_MIN);
}}

Function:
{cpp_code}
"""

# Send prompt
payload = {
    "model": MODEL,
    "prompt": prompt.strip(),
    "stream": False
}

res = requests.post(OLLAMA_URL, json=payload)

try:
    output = res.json()["response"]

    # Sanitize unwanted markdown formatting
    for tag in ["```c++", "```cpp", "```", "c++"]:
        if tag in output:
            output = output.replace(tag, "")

    # Save to test file
    os.makedirs("tests", exist_ok=True)
    with open(TEST_FILE, "w") as f:
        f.write(output.strip())

    print(f"✅ Unit test saved to: {TEST_FILE}")
except Exception as e:
    print("❌ Failed to parse response:", e)
    print(res.text)
