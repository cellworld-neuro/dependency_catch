set(CATCH_TEST_FOLDER_SOURCE ${CMAKE_CURRENT_LIST_DIR} CACHE PATH "")
set(CATCH_TEST_COUNTER 0)
if ("$ENV{CATCH_TESTS}" MATCHES "NO_TESTS")
    macro (test_library)
    endmacro()
else()
    enable_testing()
    macro (test_library library)
        if ("${ARGN}" STREQUAL "")
            file(GLOB tests_files
                    "catchtests/*.h"
                    "catchtests/*.cpp"
                    )
        else()
            set (test_files ${ARGN})
        endif()
        string(LENGTH ${CATCH_TEST_COUNTER} COUNTER_LEN)
        MATH(EXPR CATCH_TEST_COUNTER_START "2-${COUNTER_LEN}")
        string(SUBSTRING "00${CATCH_TEST_COUNTER}" ${CATCH_TEST_COUNTER_START} 2 CATCH_TEST_COUNTER_STR)
        set (test_name ${PROJECT_NAME}_${CATCH_TEST_COUNTER_STR}_tests)
        add_executable(${test_name} ${CATCH_TEST_FOLDER_SOURCE}/catchtests.cpp ${tests_files})

        set_target_properties(${test_name}
                PROPERTIES
                RUNTIME_OUTPUT_DIRECTORY ".tests")

        target_link_libraries(${test_name} ${library})

        add_test(${PROJECT_NAME}Tests .tests/${test_name})
        if ("${CMAKE_BUILD_TYPE}" MATCHES "Release")
            add_custom_command(TARGET ${test_name}
                    POST_BUILD
                    COMMAND .tests/${test_name} )
        endif()
        MATH(EXPR CATCH_TEST_COUNTER "${CATCH_TEST_COUNTER}+1")
    endmacro()
endif()