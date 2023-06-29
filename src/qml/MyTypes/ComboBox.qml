import QtQuick
import QtQuick.Controls

ComboBox {
    focus: false

    contentItem: Text {
        anchors.fill: parent
        text: parent.displayText
        font.weight: 700
        font.pixelSize: 12
        color: parent.pressed ? "#cccccc" : "#dddddd"
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        leftPadding: 5
    }

    delegate: ItemDelegate {
        height: 25
        anchors.left: parent.left
        anchors.right: parent.right
        hoverEnabled: true

        contentItem: Rectangle {
            anchors.fill: parent
            color: parent.hovered ? "#303030" : "#151515"

            Text {
                anchors.fill: parent
                text: modelData
                font.weight: 700
                font.pixelSize: 12
                color: "#cccccc"
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
                leftPadding: 5
            }
        }
    }

    background: Rectangle {
        anchors.fill: parent
        anchors.margins: 1
        color: "#222222"
        radius: 5
    }

    indicator: Text {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        width: parent.width / 5
        text: "▼"
        color: parent.pressed ? "#cccccc" : "#dddddd"
    }
}