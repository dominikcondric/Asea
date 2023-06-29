import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls
import QtQuick.Layouts
import "../MyTypes" as MyTypes

Column {
    property var skyboxComponent: entityList.getSelectedEntity().getComponent("SkyboxComponent")
    spacing: 10

    Row {
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 10
        height: 40
        
        MyTypes.Text {
            anchors.verticalCenter: parent.verticalCenter
            text: "- Blur: "
            width: 50
            verticalAlignment: Text.AlignVCenter
        }

        MyTypes.Slider {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - 70
            from: 10
            to: 700
            stepSize: 5
            value: skyboxComponent.blurLevel
            onMoved: skyboxComponent.setBlurLevel = value
        }
    }

    Row {
        spacing: 10
        
        Text {
            text: "- Texture path:"
            width: contentWidth
            font.weight: 400
            verticalAlignment: Text.AlignVCenter
            color: "#cccccc"
            font.pixelSize: 13
        }

        MyTypes.Button {
            text: "+"
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter
            onClicked: fileDialog.open()
        }
    }

    Column {
        spacing: 5
        anchors.left: parent.left
        anchors.right: parent.right
        
        Repeater {
            id: repeater
            model: ["+X", "-X", "+Y", "-Y", "+Z", "-Z"]

            delegate: RowLayout {
                spacing: 10
                height: 30
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                property alias path: texturePath.text

                Text {
                    text: modelData + ": "
                    Layout.preferredWidth: 5
                    Layout.fillHeight: true
                    font.weight: 400
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: "#cccccc"
                    font.pixelSize: 13
                }

                MyTypes.TextField {
                    id: texturePath
                    readOnly: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    font.weight: 400
                    verticalAlignment: Text.AlignVCenter
                    color: "#cccccc"
                    font.pixelSize: 13
                    placeholderText:  "Skybox map path..."
                }
            }
        }
    }

    FileDialog {
        id: fileDialog
        fileMode: FileDialog.OpenFiles
        title: "Open images..."
        options: FileDialog.ReadOnly
        nameFilters: ["Image files (*.jpg, *.jpeg, *.png)"]
        onAccepted: {
            if (selectedFiles.length != 6) {
                console.log("Not enough files selected to form a cubemap!")
                return
            }

            var pathsList = []
            for (let i = 0; i < selectedFiles.length; ++i) {
                var path = selectedFiles[i].toString();
                // remove prefixed "file:///"
                path = path.replace(/^(file:\/{3})|(qrc:\/{2})|(http:\/{2})/,"");
                // unescape html codes like '%23' for '#'
                path = decodeURIComponent(path);
                pathsList.push(path)
                repeater.itemAt(i).path = path
            }

            skyboxComponent.setTexture(pathsList, entityList.getSelectedEntity(), entityList.model.getSceneWrapper())
        }
    }
}