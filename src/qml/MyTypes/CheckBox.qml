import QtQuick
import QtQuick.Controls

CheckBox {
    id: checkbox
    
    contentItem: Text {
        anchors.left: parent.left
        text: parent.text
        verticalAlignment: Text.AlignVCenter
        color: "#cccccc"
        font.pixelSize: 14
        font.weight: 400
    }

    indicator: Rectangle {
        width: height
        height: 20
        anchors.verticalCenter: parent.verticalCenter
        radius: 3
        x: parent.contentItem.contentWidth + 10
        border.color: parent.checked ? "#019e0b" : "#444444"
        border.width: 2
        color: "#101010"

        Rectangle {
            width: parent.width / 2
            height: parent.height / 2
            x: width / 2
            y: height / 2
            radius: 2
            color: "#019e0b"
            visible: checkbox.checked
        }
    }
}