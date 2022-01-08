set(CATCH_TEST_FOLDER_SOURCE ${CMAKE_CURRENT_LIST_DIR} CACHE PATH "")
set(CATCH_TEST_COUNTER 0)
if ("$ENV{CATCH_TESTS}" MATCHES "NO_TESTS")
    macro (test_library)
    endmacro()
else()
    enable_testing()
    macro(test_library library)
        if ("${ARGN}" STREQUAL "")
            file(GLOB CATCH_TEST_FILES
                    "catchtests/*.h"
                    "catchtests/*.cpp"
                    )
        else()
            set (CATCH_TEST_FILES ${ARGN})
        endif()
        string(LENGTH ${CATCH_TEST_COUNTER} COUNTER_LEN)
        MATH(EXPR CATCH_TEST_COUNTER_START "2-${COUNTER_LEN}")
        string(SUBSTRING "00${CATCH_TEST_COUNTER}" ${CATCH_TEST_COUNTER_START} 2 CATCH_TEST_COUNTER_STR)
        set (CATCH_TEST_NAME ${PROJECT_NAME}_${CATCH_TEST_COUNTER_STR}_tests)
        add_executable(${CATCH_TEST_NAME} ${CATCH_TEST_FOLDER_SOURCE}/catchtests.cpp ${CATCH_TEST_FILES})

        set_target_properties(${CATCH_TEST_NAME}
                PROPERTIES
                RUNTIME_OUTPUT_DIRECTORY ".tests")

        target_link_libraries(${CATCH_TEST_NAME} ${library})

        add_test(${PROJECT_NAME}Tests .tests/${CATCH_TEST_NAME})
        if ("${CMAKE_BUILD_TYPE}" MATCHES "Release")
            add_custom_command(TARGET ${CATCH_TEST_NAME}
                    POST_BUILD
                    COMMAND .tests/${CATCH_TEST_NAME} )
        endif()
        MATH(EXPR CATCH_TEST_COUNTER "${CATCH_TEST_COUNTER}+1")
    endmacro()

    macro(test_files)
        set(test_files "")
        set(source_files "")
        message(STATUS "\nARGN: ${ARGN}\n")
        foreach(arg IN ITEMS ${ARGN})
            message(STATUS "\n ARG : ${arg} \n")
        endforeach()
    endmacro()
endif()