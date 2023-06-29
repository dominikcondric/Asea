import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import "../MyTypes" as MyTypes

Column {
    property var meshComponent: entityList.getSelectedEntity().getComponent("MeshComponent")
    anchors.left: parent.left
    anchors.right: parent.right
    spacing: 10

    MyTypes.CheckBox {
        width: parent.width
        text: "- Lightened: "
        checked: meshComponent.lightened
        onClicked: meshComponent.lightened = checked
    }

    Column {
        spacing: 5
        width: parent.width - anchors.leftMargin

        RowLayout {
            width: parent.width
            height: 20
            spacing: 10
            
            MyTypes.Text {
                id: modelText
                Layout.fillHeight: true
                Layout.preferredWidth: contentWidth
                text: "- Model:"
            }

            MyTypes.ComboBox {
                id: combo
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: ["Sphere", "Cube", "Ray", "Plane", "Custom"]
            }
        }

        RowLayout {
            height: 55
            spacing: 5
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.leftMargin: 10

            MyTypes.Button {
                id: button
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: 20
                Layout.preferredHeight: 20
                text: meshComponent.loaded ? "-" : "+"
                onPressed: {
                    if (text === "+") {
                        if (combo.currentText === "Custom") {
                            fileDialog.open()
                        } else {
                            meshComponent.setModel(combo.currentText, entityList.getSelectedEntity(), entityList.model)
                            modelName.text = combo.currentText
                            button.text = "-"
                        }
                    } else {
                        meshComponent.freeModel()
                        modelPath.clear()
                        modelName.clear()
                        text = "+"
                    }
                    
                }
            }

            ColumnLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: 5

                MyTypes.TextField {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 25
                    readOnly: true
                    id: modelName
                    text: meshComponent.modelName
                    placeholderText: "Model name..."
                }

                MyTypes.TextField {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 25
                    readOnly: true
                    id: modelPath
                    text: meshComponent.modelPath
                    placeholderText: "Model path..."
                }
            }
        }
    }

    FileDialog {
        id: fileDialog
        title: "Open model..."
        options: FileDialog.ReadOnly
        nameFilters: ["Model files (*.obj)"]
        onAccepted: {
            var path = selectedFile.toString();
            // remove prefixed "file:///"
            path = path.replace(/^(file:\/{3})|(qrc:\/{2})|(http:\/{2})/,"");
            // unescape html codes like '%23' for '#'
            path = decodeURIComponent(path);

            meshComponent.setModel(path, entityList.getSelectedEntity(), entityList.model)
            modelPath.text = path
            button.text = "-"
        }
    }
}