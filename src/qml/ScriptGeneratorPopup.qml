import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import "MyTypes" as MyTypes
import SceneEditor

Popup {
    id: scriptGeneratorPopup
    padding: 0
    width: 400
    height: contentHeight
    modal: true
    anchors.centerIn: Overlay.overlay
    background: Rectangle {
        color: "#303030"
        anchors.fill: parent
    }

    Column {
        width: parent.width
        spacing: 15

        Text {
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
            height: 40
            text: "Script generator"
            color: "white"
            font.pixelSize: 16
            font.weight: 900

            Rectangle {
                width: parent.width
                anchors.top: parent.bottom
                height: 2
                color: "#202020"
                radius: 10
            }
        }

        RowLayout {
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 40
            spacing: 10

            Text {
                verticalAlignment: Text.AlignVCenter
                Layout.preferredWidth: contentWidth
                Layout.fillHeight: true
                text: "Class name:"
                color: "#cccccc"
                font.pixelSize: 15
                font.weight: 400
            }

            TextField {
                id: classNameTextField
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#cccccc"
                font.pixelSize: 15
                font.weight: 400

                background: Rectangle {
                    anchors.fill: parent
                    color: "#252525"
                    radius: 3
                }
            }
        }

        RowLayout {
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 40
            spacing: 10

            Text {
                verticalAlignment: Text.AlignVCenter
                Layout.preferredWidth: contentWidth
                Layout.fillHeight: true
                text: "Directory:"
                color: "#cccccc"
                font.pixelSize: 15
                font.weight: 400
            }

            TextField {
                id: directoryTextField
                readOnly: true
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#cccccc"
                font.pixelSize: 15
                font.weight: 400

                background: Rectangle {
                    anchors.fill: parent
                    color: "#252525"
                    radius: 3
                }
            }

            MyTypes.Button {
                Layout.preferredWidth: parent.height
                Layout.fillHeight: true
                text: "..."
                onClicked: fileDialog.open()
            }

           FolderDialog {
                id: fileDialog
                options: FileDialog.ReadOnly

                onAccepted: {
                    var path = selectedFolder.toString();
                    // remove prefixed "file:///"
                    path = path.replace(/^(file:\/{3})|(qrc:\/{2})|(http:\/{2})/,"");
                    // unescape html codes like '%23' for '#'
                    path = decodeURIComponent(path);
                    directoryTextField.text = path
                }
            }
        }

        Item {
            height: 40
            width: parent.width
            MyTypes.Button {
                height: 30
                width: 70
                text: "Generate"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    const isUpperCase = (string) => /^[A-Z]*$/.test(string)

                    if (classNameTextField.text === "") {
                        console.log("Class name is empty!")
                        return
                    }

                    if (directoryTextField.text === "") {
                        console.log("Directory is empty!")
                        return
                    }

                    if (!isUpperCase(classNameTextField.text.charAt(0))) {
                        console.log("Class name must start with capital letter!")
                        return
                    }

                    Utility.generateScript(directoryTextField.text, classNameTextField.text)
                    scriptGeneratorPopup.close()
                }
            }
        }
    }
}