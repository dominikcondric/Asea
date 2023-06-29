import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import "../MyTypes" as MyTypes

Column {
    property var textureComponent: entityList.getSelectedEntity().getComponent("TextureComponent")
    spacing: 15
    anchors {
        left: parent.left
        right: parent.right
        rightMargin: 10
    }
    
    Column {
        width: parent.width
        spacing: 5

        MyTypes.Text {
            id: diffuseMapText
            text: "Diffuse map:"
        }

        RowLayout {
            id: diffuseMapRow
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: parent.width
            height: 20
            spacing: 5

            MyTypes.Button {
                id: diffuseMapButton
                Layout.preferredHeight: 20
                Layout.preferredWidth: 20
                text: "+"
                onClicked: {
                    fileDialog.callerID = diffuseMapRow
                    if (text === "+") {
                        fileDialog.open()
                    } else {
                        textureComponent.setDiffuseMap("", entityList.getSelectedEntity())
                        text = "+"
                        diffuseMapPath.clear()
                    }
                }
            }

            MyTypes.TextField {
                id: diffuseMapPath
                Layout.fillWidth: true
                rightPadding: 5
                readOnly: true
                text: textureComponent.diffuseMapPath
                placeholderText: "Diffuse map path..."
            }

            function onAccepted(imagePath) {
                textureComponent.setDiffuseMap(imagePath, entityList.getSelectedEntity(), entityList.model.getSceneWrapper())
                diffuseMapPath.text = textureComponent.diffuseMapPath
                diffuseMapButton.text = "-"
            }
        }
    }

    Column {
        spacing: 5
        width: parent.width
        
        MyTypes.Text {
            id: specularMapText
            text: "Specular map:"
        }

        RowLayout {
            id: specularMapRow
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: parent.width
            height: 20
            spacing: 5

            MyTypes.Button {
                id: specularMapButton
                Layout.preferredHeight: 20
                Layout.preferredWidth: Layout.preferredHeight
                text: "+"
                onClicked: {
                    fileDialog.callerID = specularMapRow
                    if (text === "+") {
                        fileDialog.open()
                    } else {
                        textureComponent.setSpecularMap("", entityList.getSelectedEntity())
                        text = "+"
                        specularMapPath.clear()
                    }
                }
            }

            MyTypes.TextField {
                id: specularMapPath
                Layout.fillWidth: true
                readOnly: true
                text: textureComponent.specularMapPath
                placeholderText: "Specular map path..."
            }

            function onAccepted(imagePath) {
                textureComponent.setSpecularMap(imagePath, entityList.getSelectedEntity(), entityList.model.getSceneWrapper())
                specularMapPath = textureComponent.specularMapPath
                specularMapButton.text = "-"
            }
        }
    }

    Column {
        spacing: 5
        width: parent.width

        MyTypes.Text {
            id: normalMapText
            text: "Normal map:"
        }

        RowLayout {
            id: normalMapRow
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: parent.width
            height: 20
            spacing: 5

            MyTypes.Button {
                id: normalMapButton
                Layout.preferredHeight: 20
                Layout.preferredWidth: Layout.preferredHeight
                text: "+"
                onClicked: {
                    fileDialog.callerID = normalMapRow
                    if (text === "+") {
                        fileDialog.open()
                    } else {
                        textureComponent.setNormalMap("", entityList.getSelectedEntity())
                        text = "+"
                        normalMapPath.text = ""
                    }
                }
            }

            MyTypes.TextField {
                readOnly: true
                Layout.fillWidth: true
                text: textureComponent.normalMapPath
                placeholderText: "Normal map path..."
            }

            function onAccepted(imagePath) {
                textureComponent.setNormalMap(imagePath, entityList.getSelectedEntity(), entityList.model.getSceneWrapper())
                normalMapText.text = textureComponent.normalMapPath
                normalMapButton.text = "-"
            }
        }
    }

    FileDialog {
        id: fileDialog
        title: "Open image..."
        options: FileDialog.ReadOnly
        nameFilters: ["Image files (*.jpg, *.jpeg, *.png)"]
        property var callerID
        onAccepted: {
            var path = selectedFile.toString();
            // remove prefixed "file:///"
            path = path.replace(/^(file:\/{3})|(qrc:\/{2})|(http:\/{2})/,"");
            // unescape html codes like '%23' for '#'
            path = decodeURIComponent(path);
            callerID.onAccepted(path)
        }
    }
}