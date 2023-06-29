set(CMAKE_AUTOMOC ON)

find_package(Qt6 6.4.2 REQUIRED COMPONENTS Quick QuickControls2 Gui REQUIRED)

qt_add_executable(SceneEditor
    main.cpp
    Utility/Commands/Command.h
    Utility/Commands/LoadMeshCommand.h Utility/Commands/LoadMeshCommand.cpp
    Utility/Commands/LoadTextureCommand.h Utility/Commands/LoadTextureCommand.cpp
    Utility/Commands/LoadSkyboxCommand.h Utility/Commands/LoadSkyboxCommand.cpp
    Utility/Commands/LoadScriptCommand.h Utility/Commands/LoadScriptCommand.cpp
    SceneItemRenderer.h     SceneItemRenderer.cpp
    CopyRenderer.h          CopyRenderer.cpp
    Wrappers/EntityWrapper.h  Wrappers/EntityWrapper.cpp
    Wrappers/SceneWrapper.h
    Wrappers/RenderingSystemWrapper.h
    Wrappers/ScriptComponentWrapper.h
    Wrappers/ColorComponentWrapper.h
    Wrappers/TransformComponentWrapper.h
    Wrappers/SkyboxComponentWrapper.h
    Wrappers/TextureComponentWrapper.h
    Wrappers/MeshComponentWrapper.h
    Wrappers/LightComponentWrapper.h
    Wrappers/TagComponentWrapper.h
    Wrappers/CameraComponentWrapper.h
)

qt6_add_qml_module(SceneEditor
    URI SceneEditor
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/EntityList.qml
        qml/CustomMenuBar.qml
        qml/ScriptGeneratorPopup.qml
        qml/ProjectGeneratorPopup.qml
        qml/ComponentEditors/ColorComponentEditor.qml
        qml/ComponentEditors/ScriptComponentEditor.qml
        qml/ComponentEditors/CameraComponentEditor.qml
        qml/ComponentEditors/TagComponentEditor.qml
        qml/ComponentEditors/TransformComponentEditor.qml
        qml/ComponentEditors/LightComponentEditor.qml
        qml/ComponentEditors/TextureComponentEditor.qml
        qml/ComponentEditors/MeshComponentEditor.qml
        qml/ComponentEditors/SkyboxComponentEditor.qml
        qml/ComponentEditors/TransformRow.qml
        qml/ComponentEditors/TransformButton.qml
        qml/SystemEditors/RenderingSystemEditor.qml
        qml/MyTypes/Slider.qml
        qml/MyTypes/Button.qml
        qml/MyTypes/MenuItem.qml
        qml/MyTypes/Menu.qml
        qml/MyTypes/Panel.qml
        qml/MyTypes/RoundButton.qml
        qml/MyTypes/CheckBox.qml
        qml/MyTypes/RadioButton.qml
        qml/MyTypes/ComboBox.qml
        qml/MyTypes/SpinBox.qml
        qml/MyTypes/Text.qml
        qml/MyTypes/TextField.qml

    SOURCES
        SceneItem.h             SceneItem.cpp
        EntityListModel.h       EntityListModel.cpp
        Utility.h       Utility.cpp
)

target_include_directories(SceneEditor
    PRIVATE
        ${CMAKE_SOURCE_DIR}
)

target_compile_definitions(SceneEditor
    PRIVATE
        OUTPUT_DIR="${CMAKE_CURRENT_BINARY_DIR}"
)

target_link_libraries(SceneEditor
    PRIVATE
        Coa
        Qt6::Core
        Qt6::Quick
        Qt6::QuickControls2
)

add_library(SceneEditorScripts
    SHARED
        CameraMovementScript.h
        CameraMovementScript.cpp
)

target_link_libraries(SceneEditorScripts
    PRIVATE
        Coa
)

target_compile_definitions(SceneEditorScripts
    PRIVATE
        COA_BUILD_DLL
)