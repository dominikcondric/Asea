import QtQuick
import QtQuick.Controls

Button {
    id: button
    flat: true
    default property alias backgroundRect: bcg

    contentItem: Label {
        text: parent.text
        color: "#cccccc"
        font.weight: 400
        font.pixelSize: 14
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
    }

    background: Rectangle {
        id: bcg
        anchors.fill: parent
        color: parent.down ? "#444444" : "#222222"
        radius: 2
        border.width: 1
        border.color: "#888888"
    }
}