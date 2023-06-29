import QtQuick
import QtQuick.Dialogs
import "../MyTypes" as MyTypes

Item {
    anchors.fill: parent

    Row {
        spacing: 15

        MyTypes.Text {
            width: contentWidth
            height: 30
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: "- Color:"
        }

        Rectangle {
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter
            color: colorDialog.selectedColor
            MouseArea {
                anchors.fill: parent
                onClicked: colorDialog.open()
            }
        }

        ColorDialog {
            id: colorDialog
            options: ColorDialog.ShowAlphaChannel
            selectedColor: entityList.getSelectedEntity().getComponent("ColorComponent").color
            onAccepted: entityList.getSelectedEntity().getComponent("ColorComponent").color = selectedColor
        }
    }
}