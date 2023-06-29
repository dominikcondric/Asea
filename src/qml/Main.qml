import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SceneEditor
import "./ComponentEditors"
import "./SystemEditors"
import "./MyTypes" as MyTypes

ApplicationWindow {
    id: window
    visible: true
    width: 1024
    height: 768

    menuBar: CustomMenuBar {}
        
    // Background gradient
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            id: gradient
            orientation: Gradient.Horizontal
            GradientStop {
                color: "#151515"
                position: 0.0
            }

            GradientStop {
                color: "#050505"
                position: sceneItem.x / window.width
            }

            GradientStop {
                color: "#050505"
                position: (sceneItem.width + sceneItem.x) / window.width
            }

            GradientStop {
                color: "#151515"
                position: 1.0
            }
        }
    }

    // Panels
    SplitView {
        anchors.fill: parent

        handle: Rectangle {
            implicitWidth: 2
            implicitHeight: parent.height
            color: "#303030"
        }

        MyTypes.Panel {
            SplitView.fillHeight: true
            SplitView.minimumWidth: 150
            SplitView.preferredWidth: 220
            SplitView.maximumWidth: 300

            EntityList {
                id: entityList
                anchors.fill: parent
                onCurrentIndexChanged: {
                    componentsComboBox.onCurrentTextChanged();
                }

                Component.onCompleted: sceneItem.setScene(entityList.model.getSceneWrapper())
            }
        }

        SceneItem {
            id: sceneItem
            SplitView.fillWidth: true
            SplitView.minimumHeight: parent.height * 0.75
            anchors.top: parent.top
            anchors.margins: 2.
            onWidthChanged: onResize(width, height)
            onHeightChanged: onResize(width, height)

            Timer {
                id: timer
                interval: 10
                running: true
                repeat: true
                property real lastTime: new Date().getTime()
                onTriggered: {
                    let newTime = new Date().getTime();
                    sceneItem.updateScene((newTime - lastTime) / 1e3);
                    lastTime = newTime;
                }
            }
        }

        Item {
            SplitView.fillHeight: true
            SplitView.minimumWidth: 150
            SplitView.preferredWidth: 220
            SplitView.maximumWidth: 300

            MyTypes.Panel {
                id: componentEditorRectangle
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height / 2

                MyTypes.ComboBox {
                    id: componentsComboBox
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    implicitHeight: 30

                    model: ["ColorComponent", "TransformComponent", "MeshComponent", 
                    "SkyboxComponent", "LightComponent", "TextureComponent",
                    "TagComponent", "CameraComponent", "ScriptComponent"]
                    
                    onCurrentTextChanged: {
                        if (entityList.currentIndex !== -1) {
                            if (entityList.getSelectedEntity().hasComponent(componentsComboBox.currentText)) {
                                addComponentButton.visible = false;
                                removeComponentButton.visible = true
                                if (componentsComboBox.currentText === "TransformComponent" || 
                                    componentsComboBox.currentText === "TagComponent")
                                    removeComponentButton.visible = false;

                                switch (componentsComboBox.currentText) {
                                    case "ColorComponent": componentLoader.sourceComponent = colorComponentEditor; break;
                                    case "TagComponent": componentLoader.sourceComponent = tagComponentEditor; break;
                                    case "TransformComponent": componentLoader.sourceComponent = transformComponentEditor; break;
                                    case "LightComponent": componentLoader.sourceComponent = lightComponentEditor; break;
                                    case "TextureComponent": componentLoader.sourceComponent = textureComponentEditor; break;
                                    case "MeshComponent": componentLoader.sourceComponent = meshComponentEditor; break;
                                    case "SkyboxComponent": componentLoader.sourceComponent = skyboxComponentEditor; break;
                                    case "CameraComponent": componentLoader.sourceComponent = cameraComponentEditor; break;
                                    case "ScriptComponent": componentLoader.sourceComponent = scriptComponentEditor; break;
                                }
                            } else {
                                addComponentButton.visible = true
                                removeComponentButton.visible = false
                                componentLoader.sourceComponent = undefined
                            }
                        } else {
                            componentLoader.sourceComponent = undefined
                            addComponentButton.visible = false
                            removeComponentButton.visible = false
                        }
                    }
                }

                MyTypes.RoundButton {
                    visible: false
                    id: addComponentButton
                    width: 30
                    height: 30
                    fillColor: !down ? "#019e0b" : Qt.lighter("#019e0b", 1.2)
                    text: "+"
                    anchors {
                        bottom: parent.bottom
                        right: parent.right
                        bottomMargin: 10
                        rightMargin: 10
                    }

                    onClicked: {
                        entityList.getSelectedEntity().addComponent(componentsComboBox.currentText)
                        componentsComboBox.onCurrentTextChanged()
                    }                
                }

                MyTypes.RoundButton {
                    visible: false
                    id: removeComponentButton
                    width: 30
                    height: 30
                    fillColor: !down ? "red" : Qt.lighter("red", 1.2)
                    text: "-"
                    anchors {
                        bottom: parent.bottom
                        right: parent.right
                        bottomMargin: 10
                        rightMargin: 10
                    }

                    onClicked: {
                        entityList.getSelectedEntity().removeComponent(componentsComboBox.currentText)
                        componentsComboBox.onCurrentTextChanged()
                    }
                }

                ScrollView {
                    z: -1
                    anchors.fill: parent
                    anchors.topMargin: componentsComboBox.height + 10
                    anchors.bottomMargin: 20
                    ScrollBar.vertical.policy: ScrollBar.AsNeeded
                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                    contentHeight: componentLoader.implicitHeight
                    contentWidth: parent.width

                    Loader {
                        id: componentLoader
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        anchors.bottomMargin: 10
                    }
                }

                Component {
                    id: colorComponentEditor
                    ColorComponentEditor {}
                }

                Component {
                    id: tagComponentEditor
                    TagComponentEditor {}
                }

                Component {
                    id: cameraComponentEditor
                    CameraComponentEditor {}
                }

                Component {
                    id: transformComponentEditor
                    TransformComponentEditor {}
                }

                Component {
                    id: scriptComponentEditor
                    ScriptComponentEditor {}
                }

                Component {
                    id: lightComponentEditor
                    LightComponentEditor {}
                }

                Component {
                    id: textureComponentEditor
                    TextureComponentEditor {}
                }

                Component {
                    id: meshComponentEditor
                    MeshComponentEditor {}
                }

                Component {
                    id: skyboxComponentEditor
                    SkyboxComponentEditor {}
                }
            }

            // Systems settings
            MyTypes.Panel {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height / 2

                MyTypes.ComboBox {
                    id: systemsComboBox
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    implicitHeight: 30

                    model: ["RenderingSystem"]

                    onCurrentTextChanged: {
                        if (currentText === "RenderingSystem")
                            rendererLoader.sourceComponent = renderingSystemComponent
                    }

                    Loader {
                        id: rendererLoader

                        anchors {
                            topMargin: 30
                            left: parent.left
                            right: parent.right
                            top: parent.top
                            margins: 10
                        }
                    }

                    Component {
                        id: renderingSystemComponent
                        RenderingSystemEditor {}
                    }
                }
            }
        }
    }
}