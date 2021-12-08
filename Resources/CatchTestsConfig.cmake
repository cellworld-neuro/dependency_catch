set(CATCH_TEST_FOLDER_SOURCE ${CMAKE_CURRENT_LIST_DIR} CACHE PATH "")
if (${CATCH_TEST} EQUAL "NO_TEST")
    function (test_library)
    endfunction()
else()
    function (test_library)
        set (libraries ${ARGN})

        file(GLOB ${PROJECT_NAME}_tests_glob
                "catchtests/*.h"
                "catchtests/*.cpp"
                )

        add_executable(${PROJECT_NAME}_tests ${CATCH_TEST_FOLDER_SOURCE}/catchtests.cpp ${${PROJECT_NAME}_tests_glob})

        set_target_properties(${PROJECT_NAME}_tests
                PROPERTIES
                RUNTIME_OUTPUT_DIRECTORY ".tests")

        target_link_libraries(${PROJECT_NAME}_tests ${libraries})

        add_test(${PROJECT_NAME}Tests .tests/${PROJECT_NAME}_tests)

        if (${CMAKE_BUILD_TYPE} EQUAL "Release")
            add_custom_command(TARGET ${PROJECT_NAME}_tests
                    POST_BUILD
                    COMMAND .tests/${PROJECT_NAME}_tests )
        endif()
    endfunction()

endif()
