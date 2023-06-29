import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import "MyTypes" as MyTypes
import SceneEditor

MenuBar {
    MyTypes.Menu {
        title: qsTr("File")

        MyTypes.MenuItem {
            text: "New scene..."

            onTriggered: {
                entityList.model.initializeScene(sceneItem.width, sceneItem.height);
                entityList.forceLayout()
            }
        }

        MyTypes.MenuItem {
            text: "New project..."

            onTriggered: {
                projectGenerator.open()
            }

            ProjectGeneratorPopup {
                id: projectGenerator
            }
        }
    }

    MyTypes.Menu { 
        title: qsTr("Tools") 

        MyTypes.MenuItem {
            text: "Script generator"

            onTriggered: {
                scriptGenerator.open()
            }

            ScriptGeneratorPopup {
                id: scriptGenerator
            }
        }
    }

    background: Rectangle {
        anchors.fill: parent
        color: "#252525"
    }

    delegate: MenuBarItem {
        id: menuBarItem

        contentItem: Text {
            text: menuBarItem.text
            font: menuBarItem.font
            color: "#cccccc"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            anchors.top: parent.top
            height: parent.height
            color: menuBarItem.highlighted ? "#019e0b" : "transparent"
        }
    }
}