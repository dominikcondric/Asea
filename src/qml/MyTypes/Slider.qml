import QtQuick
import QtQuick.Controls

Slider {
    id: intensitySlider

    handle: Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        color: "#019e0b"
        border.color: "#101010"
        width: 20
        height: width
        radius: width / 2
        x: parent.background.x + parent.background.width * (parent.value / (parent.to - parent.from)) - width / 2
    }

    background: Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        color: "#444444"
        height: parent.height / 6
        width: parent.width
        radius: 4

        Rectangle {
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }
            
            radius: 4
            width: intensitySlider.handle.x + intensitySlider.handle.width / 2
            color: "#019e0b"
        }
    }
}