#define CATCH_CONFIG_RUNNER
#include<catch.h>
#include <iostream>

using namespace std;

int main( int argc, char* argv[] ) {
    cout << endl << "Catch 2.0 Automatic CMAKE integration by German Espinosa v1.0.2020" << endl;
    int result = Catch::Session().run( argc, argv );
    return result;
}