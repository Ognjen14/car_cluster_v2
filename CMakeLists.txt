cmake_minimum_required(VERSION 3.16)

project(car_cluster_v2 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Qml Core)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appcar_cluster_v2
    main.cpp
)

qt_add_qml_module(appcar_cluster_v2
    URI car_cluster_v2
    VERSION 1.0
    QML_FILES
        Main.qml
        qml/ControlPanel.qml
        qml/FuelDial.qml
        qml/MainMenu.qml
        qml/RMPDial.qml
        qml/SpeedDial.qml
        qml/TemperatureDial.qml
        qml/TCPHandler.qml
        data/CarClusterData.qml
)
qt_add_resources(appcar_cluster_v2 "assets"
    PREFIX "/"
    FILES
        icons/fuelIconOff.png
        icons/fuelIconOn.png
        icons/albums/appetite.jpg
        icons/background.jpg
        icons/caller.png
        icons/motorTemp.png
        icons/fuel_left.png
        icons/avg_speed.png
        icons/fuel_cons.png
        icons/left_arrow.png
        icons/right_arrow.png
        icons/handbrake.png
        icons/carEngine.png
        icons/carOil.png
        icons/abs.png
        fonts/ProtestGuerrilla-Regular.ttf
)



target_link_libraries(appcar_cluster_v2
    PRIVATE Qt6::Quick
            Qt6::Core
            Qt6::Qml
)
add_subdirectory(src)
target_link_libraries(appcar_cluster_v2 PUBLIC appcar_cluster_v2-Lib)
