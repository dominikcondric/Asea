import QtQuick
import QtQuick.Controls

Button {
    id: button
    flat: true
    autoRepeat: true
    autoRepeatInterval: 10
    autoRepeatDelay: 50
    property real transformFactor: 0.05
    property real min: 0
    property real max: 360
    onPressed: parent.valueToPresent = clamp(parent.valueToPresent + transformFactor, min, max)

    function clamp(num, min, max) {
        return Math.min(Math.max(num, min), max);
    }

    states: [
        State {
            name: "UP" 
            when: !button.down
        },

        State {
            name: "DOWN"
            when: button.down
        }
    ]

    transitions: [
        Transition {
            from: "UP"
            to: "DOWN"
            ColorAnimation {
                target: rect
                property: "color"
                to: "#12be2b"
                duration: 50
            }
        },

        Transition {
            from: "DOWN"
            to: "UP"
            ColorAnimation {
                target: rect
                property: "color"
                to: "#019e0b"
                duration: 50
            }
        }
    ]

    contentItem: Text {
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: parent.text
        color: "#222222"
    }

    background: Rectangle {
        id: rect
        anchors.fill: parent
        color: "#019e0b"
    }
}