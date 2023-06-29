import QtQuick
import QtQuick.Controls

MenuItem {
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.leftMargin: 1
    anchors.rightMargin: 1
    height: contentItem.contentHeight + 10

    background: Rectangle {
        color: parent.highlighted ? "#303030" : "transparent"
        anchors.fill: parent
    }
    
    contentItem: Text {
        anchors.margins: 3
        anchors.fill: parent
        font.pixelSize: 14
        font.weight: 400
        text: parent.text
        color: "#cccccc"
        verticalAlignment: Text.AlignVCenter
    }


}