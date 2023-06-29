import QtQuick
import QtQuick.Controls
import "." as MyTypes

SpinBox {
    property var indicatorsSize: 20
    height: indicatorsSize

    background: Rectangle {
        width: parent.width
        height: parent.height
        color: "#222222"
    }

    contentItem: MyTypes.Text {
        text: parent.textFromValue(parent.value, parent.locale)
        width: parent.width - 2 * parent.indicatorsSize
        x: parent.indicatorsSize
        y: 0
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    up.indicator: Rectangle {
        x: parent.width - width
        y: 0
        width: parent.indicatorsSize
        height: width
        color: "#019e0b"

        Text {
            text: "+"
            font.pixelSize: 14
            font.weight: 400
            color: "#cccccc"
            anchors.fill: parent
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    down.indicator: Rectangle {
        x: 0
        y: 0
        width: parent.indicatorsSize
        height: width
        color: "#019e0b"

        Text {
            text: "-"
            font.pixelSize: 14
            font.weight: 400
            color: "#cccccc"
            anchors.fill: parent
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}