enable_testing()
if (NOT (DISABLE_TESTING MATCHES YES))
    find_package(Catch CONFIG QUIET)

    file(GLOB ${PROJECT_NAME}_tests_glob
        "catchtests/*.h"
        "catchtests/*.cpp"
    )

    add_executable(${PROJECT_NAME}_tests ${CMAKE_CURRENT_LIST_DIR}/catchtests.cpp ${${PROJECT_NAME}_tests_glob})

    set_target_properties(${PROJECT_NAME}_tests
        PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY ".tests")

    target_link_libraries(${PROJECT_NAME}_tests catchtests)
    target_link_libraries(${PROJECT_NAME}_tests ${PROJECT_NAME})

    add_test(${PROJECT_NAME}Tests .tests/${PROJECT_NAME}_tests)

    if (CMAKE_BUILD_TYPE MATCHES Release)
        add_custom_command(TARGET ${PROJECT_NAME}_tests
                POST_BUILD
                COMMAND .tests/${PROJECT_NAME}_tests )
    endif()
endif()