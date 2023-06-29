import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import "../MyTypes" as MyTypes

Item {
    property var lightComponent: entityList.getSelectedEntity().getComponent("LightComponent")
    anchors.fill: parent

    MyTypes.CheckBox {
        id: shadowCasterCheckBox
        anchors.top: parent.top
        anchors.left: parent.left
        text: "- Shadow caster: "
        height: 25
        spacing: 5
        width: parent.width
        checked: lightComponent.shadowCaster
        onClicked: lightComponent.shadowCaster = checked
    }

    Row {
        id: colorRow
        anchors.top: shadowCasterCheckBox.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        spacing: 15

        MyTypes.Text {
            height: 30
            verticalAlignment: Text.AlignVCenter
            text: "- Color:"
        }

        Rectangle {
            width: 20
            height: 20
            color: colorDialog.selectedColor
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors.fill: parent
                onClicked: colorDialog.open()
            }
        }

        ColorDialog {
            id: colorDialog
            selectedColor: lightComponent.color
            onAccepted: lightComponent.color = selectedColor
        }
    }

    Row {
        id: intensityRow
        anchors.top: colorRow.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        height: 20
        width: parent.width
        spacing: 5

        MyTypes.Text {
            id: intensityText
            verticalAlignment: Text.AlignVCenter
            text: "- Intensity: "
        }

        MyTypes.Slider {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - intensityText.contentWidth - 15
            from: 0.
            to: 5.
            value: lightComponent.intensity
            stepSize: 0.1
            onMoved: lightComponent.intensity = value
        }
    }

    Row {
        id: cutoffRow
        anchors.top: intensityRow.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        height: 20
        width: parent.width
        spacing: 5

        MyTypes.Text {
            id: cutoffText
            verticalAlignment: Text.AlignVCenter
            text: "- Spotlight cutoff: "
        }

        MyTypes.Slider {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - cutoffText.contentWidth - 15
            from: 1.
            to: 45.
            value: lightComponent.spotlightCutoff
            stepSize: 1
            onMoved: lightComponent.spotlightCutoff = value
        }
    }

    Column {
        anchors.top: cutoffRow.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        width: parent.width
        spacing: 5

        MyTypes.Text {
            verticalAlignment: Text.AlignVCenter
            text: "- Type: "
        }

        Column {
            width: parent.width
            spacing: 3
            x: 10

            MyTypes.RadioButton {
                width: parent.width
                text: "Point"
                checked: lightComponent.type === "Point"
                onClicked: lightComponent.type = "Point"
            }

            MyTypes.RadioButton {
                width: parent.width
                text: "Directional"
                checked: lightComponent.type === "Directional"
                onClicked: lightComponent.type = "Directional"
            }

            MyTypes.RadioButton {
                width: parent.width
                text: "Spotlight"
                checked: lightComponent.type === "Spotlight"
                onClicked: lightComponent.type = "Spotlight"
            }
        }
    }
}