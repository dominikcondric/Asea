import QtQuick
import QtQuick.Controls
import "../MyTypes" as MyTypes
import QtQuick.Dialogs

Column {
    spacing: 10

    MyTypes.CheckBox {
        text: "- Shadows: "
        checked: sceneItem.getRenderingSystem().shadows
        onClicked: sceneItem.getRenderingSystem().shadows = checked
    }

    MyTypes.CheckBox {
        text: "- Helper grid: "
        checked: sceneItem.getRenderingSystem().renderHelperGrid
        onClicked: sceneItem.getRenderingSystem().renderHelperGrid = checked
    }

    Row {
        width: parent.width
        spacing: 10

        MyTypes.Text {
            text: "- Helper grid color: "
        }

        Rectangle {
            width: 20
            height: 20
            color: colorDialog.selectedColor
            MouseArea {
                anchors.fill: parent
                onClicked: colorDialog.open()
            }
        }

        ColorDialog {
            id: colorDialog
            options: ColorDialog.ShowAlphaChannel
            selectedColor: sceneItem.getRenderingSystem().helperGridColor
            onAccepted: sceneItem.getRenderingSystem().helperGridColor = selectedColor
        }
    }

    Column {
        width: parent.width
        spacing: 5

        MyTypes.Text {
            text: "- Cel shading levels: "
        }

        MyTypes.SpinBox {
            anchors.horizontalCenter: parent.horizontalCenter
            from: 0
            to: 10
            width: parent.width / 2
            value: sceneItem.getRenderingSystem().celShadingLevelsCount
            onValueChanged: sceneItem.getRenderingSystem().celShadingLevelsCount = value
        }
    }
}
