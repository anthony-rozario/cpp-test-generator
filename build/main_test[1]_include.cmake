if(EXISTS "C:/Users/KIIT/OneDrive/Desktop/My projects/cpp-test-generator/build/main_test[1]_tests.cmake")
  include("C:/Users/KIIT/OneDrive/Desktop/My projects/cpp-test-generator/build/main_test[1]_tests.cmake")
else()
  add_test(main_test_NOT_BUILT main_test_NOT_BUILT)
endif()
