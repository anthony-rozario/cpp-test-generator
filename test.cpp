// test.cpp
#include <gtest/gtest.h>

// Dummy add function
int add(int a, int b) {
    return a + b;
}

// Test cases
TEST(AddTest, PositiveNumbers) {
    EXPECT_EQ(add(2, 3), 5);
}

TEST(AddTest, NegativeAndPositive) {
    EXPECT_EQ(add(-2, 3), 1);
}

// Main for GTest
int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
