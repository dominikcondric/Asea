import QtQuick
import QtQuick.Controls

RadioButton {
    id: button

    indicator: Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        width: 20
        height: 20
        radius: width / 2
        border.color: button.checked ? "#019e0b" : "#444444"
        border.width: 2
        color: "#101010"

        Rectangle {
            width: parent.width / 2
            height: width
            x: width / 2
            y: height / 2
            radius: width / 2
            color: button.checked ? "#019e0b" : "transparent"
            visible: button.checked
        }
    }

    contentItem: Text {
        text: parent.text
        verticalAlignment: Text.AlignVCenter
        color: "#cccccc"
        font.pixelSize: 14
        font.weight: 400
        leftPadding: parent.indicator.width + 3
    }
}