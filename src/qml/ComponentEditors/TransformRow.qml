import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    height: 20
    property real valueToPresent: 0.
    property real transformFactor: 0.05
    property real min: 0
    property real max: 100
    spacing: 0

    TransformButton {
        text: "-"
        transformFactor: -parent.transformFactor
        Layout.preferredHeight: 20
        Layout.preferredWidth: Layout.preferredHeight
        min: parent.min
        max: parent.max
    }

    Label {
        id: label
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "#cccccc"
        text: Number(valueToPresent).toLocaleString(Qt.locale("de_DE"), "f", 2)
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        background: Rectangle {
            anchors.fill: parent
            color: "#222222"
        }
    }

    TransformButton {
        text: "+"
        transformFactor: parent.transformFactor
        Layout.preferredHeight: 20
        Layout.preferredWidth: Layout.preferredHeight
        min: parent.min
        max: parent.max
    }
}