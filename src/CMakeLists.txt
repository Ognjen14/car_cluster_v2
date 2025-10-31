set(appcar_cluster_v2-Lib_SOURCES
    TcpClient/tcpclientreceive.cpp
)
set(appcar_cluster_v2-Lib_INCUDEDIR
    ${CMAKE_CURRENT_SOURCE_DIR}/TcpClient
)
file(GLOB appcar_cluster_v2-Lib_HEADERS
    ${CMAKE_CURRENT_SOURCE_DIR}/TcpClient/*.h
)
set(appcar_cluster_v2-Lib_SOURCES
    ${appcar_cluster_v2-Lib_SOURCES}
    ${appcar_cluster_v2-Lib_HEADERS}
)
add_library(appcar_cluster_v2-Lib ${appcar_cluster_v2-Lib_SOURCES})

target_link_directories(appcar_cluster_v2-Lib PUBLIC ${appcar_cluster_v2-Lib_INCUDEDIR})

target_link_libraries(appcar_cluster_v2-Lib
    PUBLIC
    Qt6::Core
    Qt6::Qml
    Qt6::Quick
)
