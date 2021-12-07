set(CATCH_TEST_FOLDER_SOURCE ${CMAKE_CURRENT_LIST_DIR})
message("folder ${CMAKE_CURRENT_LIST_DIR} - ${CATCH_TEST_FOLDER_SOURCE} - ${CMAKE_CURRENT_LIST_DIR}")

function (test_library)
    set (libraries ${ARGN})

    message("folder 1 ${CMAKE_CURRENT_LIST_DIR} - ${CATCH_TEST_FOLDER_SOURCE} - ${CMAKE_CURRENT_LIST_DIR}")
    message("testing started - -")

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

    if (CMAKE_BUILD_TYPE MATCHES Release)
        add_custom_command(TARGET ${PROJECT_NAME}_tests
                POST_BUILD
                COMMAND .tests/${PROJECT_NAME}_tests )
    endif()
endfunction()