import QtQuick
import QtQuick.Controls

Button {
    flat: true
    property alias fillColor: backgroundRect.color

    contentItem: Label {
        anchors.fill: parent
        text: parent.text
        font.weight: 900
        color: "#222222"
        font.pixelSize: 14
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    background: Rectangle {
        id: backgroundRect
        anchors.fill: parent
        radius: parent.width / 2
        border.color: "#222222"
        border.width: 2
    }
}
