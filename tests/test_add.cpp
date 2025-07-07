#include <gtest/gtest.h>
#include "add.h"

TEST(AddTest, AddsTwoNumbers) {
    EXPECT_EQ(add(2, 3), 5);
}

TEST(AddTest, HandlesNegativeNumbers) {
    EXPECT_EQ(add(-1, -2), -3);
}

TEST(AddTest, HandlesLargeNumbers) {
    EXPECT_EQ(add(2147483647LL, 2147483647LL), 4294967294LL);
}

TEST(AddTest, HandlesWrappedAroundNumbers) {
    EXPECT_EQ(add(-2147483648LL, -2147483648LL), -4294967296LL);
}
