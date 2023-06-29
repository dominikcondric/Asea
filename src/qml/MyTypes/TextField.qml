import QtQuick
import QtQuick.Controls

TextField {
    id: directoryTextField
    color: Qt.lighter(background.color, 5)
    font.pixelSize: 15
    font.weight: 400
    placeholderTextColor: Qt.lighter(background.color, 2)

    background: Rectangle {
        anchors.fill: parent
        color: "#252525"
        radius: 3
    }
}