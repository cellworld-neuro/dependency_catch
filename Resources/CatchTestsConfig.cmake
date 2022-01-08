set(CATCH_TEST_FOLDER_SOURCE ${CMAKE_CURRENT_LIST_DIR} CACHE PATH "")

if ("$ENV{CATCH_TESTS}" MATCHES "NO_TESTS")
    function (test_library)
    endfunction()
else()
    enable_testing()
    function (test_library library)
        if ("${ARGN}" STREQUAL "")
            file(GLOB tests_files
                    "catchtests/*.h"
                    "catchtests/*.cpp"
                    )
        else()
            set (test_files ${ARGN})
        endif()
        add_executable(${PROJECT_NAME}_tests ${CATCH_TEST_FOLDER_SOURCE}/catchtests.cpp ${tests_files})

        set_target_properties(${PROJECT_NAME}_tests
                PROPERTIES
                RUNTIME_OUTPUT_DIRECTORY ".tests")

        target_link_libraries(${PROJECT_NAME}_tests ${library})

        add_test(${PROJECT_NAME}Tests .tests/${PROJECT_NAME}_tests)
        if ("${CMAKE_BUILD_TYPE}" MATCHES "Release")
            add_custom_command(TARGET ${PROJECT_NAME}_tests
                    POST_BUILD
                    COMMAND .tests/${PROJECT_NAME}_tests )
        endif()
    endfunction()
endif()