import QtQuick
import QtQuick.Dialogs
import QtQuick.Layouts
import QtQuick.Controls
import "../MyTypes" as MyTypes

Column {
    spacing: 15
    anchors.fill: parent
    property var scriptComponent: entityList.getSelectedEntity().getComponent("ScriptComponent")

    Column {
        spacing: 5
        anchors.left: parent.left
        anchors.right: parent.right

        MyTypes.Text {
            anchors.left: parent.left
            anchors.right: parent.right
            text: "- Shared library:"
            verticalAlignment: Text.AlignVCenter
        }

        RowLayout {
            height: 30
            anchors {
                left: parent.left
                leftMargin: 10
                right: parent.right
                rightMargin: 10
            }

            MyTypes.TextField {
                id: sharedLibraryPathField
                Layout.fillHeight: true
                Layout.fillWidth: true
                readOnly: true
                text: scriptComponent.sharedLibraryPath
                placeholderText: "Shared library path..."
            }

            MyTypes.Button {
                Layout.preferredWidth: parent.height
                Layout.preferredHeight: parent.height
                text: "..."
                visible: loadButton.visible
                onClicked: fileDialog.open()
            }
        }
    }

    Column {
        spacing: 5
        anchors.left: parent.left
        anchors.right: parent.right

        MyTypes.Text {
            anchors.left: parent.left
            anchors.right: parent.right
            text: "- Class name:"
            verticalAlignment: Text.AlignVCenter
        }

        MyTypes.TextField {
            id: className
            anchors {
                left: parent.left
                leftMargin: 10
                right: parent.right
                rightMargin: 10
            }

            height: 30
            text: scriptComponent.className
            placeholderText: "ClassName"
        }
    }

    MyTypes.Button {
        id: loadButton
        anchors.horizontalCenter: parent.horizontalCenter
        visible: scriptComponent.className === "" ? true : false
        width: parent.width / 3
        height: width / 2
        text: "Load"
        onClicked: {
            if (fileDialog.selectedPath === "") {
                console.log("Shared library path is empty!")
                return
            }

            if (fileDialog.className === "") {
                console.log("Class name is empty!")
                return
            }

            if (scriptComponent.loadScript(sharedLibraryPathField.text, className.text))
                visible = false
        }
    }

    FileDialog {
        id: fileDialog
        title: "Open shared library..."
        options: FileDialog.ReadOnly
        fileMode: FileDialog.OpenFile
        nameFilters: ["Shared library files (*.dll, *.so)"]
        onAccepted: {
            var path = selectedFile.toString();
            // remove prefixed "file:///"
            path = path.replace(/^(file:\/{3})|(qrc:\/{2})|(http:\/{2})/,"");
            // unescape html codes like '%23' for '#'
            path = decodeURIComponent(path);
            sharedLibraryPathField.text = path
        }
    }
}