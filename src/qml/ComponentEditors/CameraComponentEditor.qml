import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../MyTypes" as MyTypes

Column {
    id: root
    property var cameraComponent: entityList.getSelectedEntity().getComponent("CameraComponent")
    anchors.left: parent.left
    anchors.right: parent.right
    spacing: 15

    Column {
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 5

        MyTypes.Text {
            text: "- Projection:"
        }

        MyTypes.RadioButton {
            text: "Perspective"
            anchors.left: parent.left
            anchors.leftMargin: 20
            checked: root.cameraComponent.type === 1
            onClicked: root.cameraComponent.type = 1 
        }

        MyTypes.RadioButton {
            text: "Orthographic"
            anchors.left: parent.left
            anchors.leftMargin: 20
            checked: root.cameraComponent.type === 0
            onClicked: root.cameraComponent.type = 0
        }
    }

    Column {
        width: parent.width
        spacing: 5

        MyTypes.Text {
            text: "- Position:"
            verticalAlignment: Text.AlignVCenter
        }

        RowLayout {
            width: parent.width / 2
            anchors.horizontalCenter: parent.horizontalCenter
            height: 20
            spacing: 5

            Text {
                Layout.preferredWidth: 20
                Layout.fillHeight: true
                text: "X: "
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 14
                font.weight: 400
                color: "#cccccc"
            }

            Label {
                id: positionX
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: cameraComponent.position.x
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 14
                font.weight: 400
                color: "#cccccc"

                background: Rectangle {
                    color: "#202020"
                    anchors.fill: parent
                }
            }
        }

        RowLayout {
            width: parent.width / 2
            anchors.horizontalCenter: parent.horizontalCenter
            height: 20
            spacing: 5

            MyTypes.Text {
                Layout.preferredWidth: 20
                Layout.fillHeight: true
                text: "Y: "
                verticalAlignment: Text.AlignVCenter
            }

            Label {
                id: positionY
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: cameraComponent.position.y
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 14
                font.weight: 400
                color: "#cccccc"

                background: Rectangle {
                    color: "#202020"
                    anchors.fill: parent
                }
            }
        }

        RowLayout {
            width: parent.width / 2
            anchors.horizontalCenter: parent.horizontalCenter
            height: 20
            spacing: 5

            MyTypes.Text {
                Layout.preferredWidth: 20
                Layout.fillHeight: true
                text: "Z: "
                verticalAlignment: Text.AlignVCenter
            }

            Label {
                id: positionZ
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: cameraComponent.position.z
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 14
                font.weight: 400
                color: "#cccccc"

                background: Rectangle {
                    color: "#202020"
                    anchors.fill: parent
                }
            }
        }
    }

    RowLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 5
        height: 20

        MyTypes.Text {
            text: "- Near:"
            Layout.preferredWidth: 80
            Layout.fillHeight: true
        }

        TransformRow {
            id: nearPlaneTransformRow
            valueToPresent: cameraComponent.nearPlane
            Layout.fillHeight: true
            Layout.fillWidth: true
            onValueToPresentChanged: cameraComponent.nearPlane = valueToPresent
            min: 0.1
            max: farPlaneTransformRow.valueToPresent
        }
    }

    RowLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 5
        height: 20

        MyTypes.Text {
            text: "- Far:"
            Layout.preferredWidth: 80
            Layout.fillHeight: true
        }

        TransformRow {
            id: farPlaneTransformRow
            Layout.fillHeight: true
            Layout.fillWidth: true
            valueToPresent: cameraComponent.farPlane
            onValueToPresentChanged: cameraComponent.farPlane = valueToPresent
            min: nearPlaneTransformRow.valueToPresent
            max: 200.
        }
    }

    MyTypes.CheckBox {
        text: "- Main: "
        checked: cameraComponent.isMain
        onClicked: { 
            if (!cameraComponent.isMain) {
                cameraComponent.setMain()
                checked = true
            }
        }
    }

    RowLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 5
        height: 20

        MyTypes.Text {
            text: "Fov:"
            Layout.preferredWidth: 80
            Layout.fillHeight: true
        }

        TransformRow {
            Layout.fillHeight: true
            Layout.fillWidth: true
            valueToPresent: cameraComponent.fov
            onValueToPresentChanged: cameraComponent.fov = valueToPresent
            transformFactor: 1
            min: 20.
            max: 120.
        }
    }

    RowLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 5
        height: 20

        MyTypes.Text {
            text: "Aspect ratio:"
            Layout.preferredWidth: 80
            Layout.fillHeight: true
            elide: Text.ElideLeft
        }

        TransformRow {
            Layout.fillHeight: true
            Layout.fillWidth: true
            valueToPresent: cameraComponent.aspectRatio
            onValueToPresentChanged: cameraComponent.aspectRatio = valueToPresent
            min: 0.1
            max: 2.
        }
    }

    MyTypes.Text {
        text: "- Orthographic side planes:"
        verticalAlignment: Text.AlignVCenter
    }

    Column {
        spacing: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 5
            height: 20

            MyTypes.Text {
                text: "Left:"
                Layout.preferredWidth: 60
                Layout.fillHeight: true
                elide: Text.ElideLeft
            }

            TransformRow {
                Layout.fillHeight: true
                Layout.fillWidth: true
                valueToPresent: cameraComponent.orthographicPlanes.x
                onValueToPresentChanged: cameraComponent.setOrthographicPlane(0, valueToPresent)
            }
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 5
            height: 20

            MyTypes.Text {
                text: "Right:"
                Layout.preferredWidth: 60
                Layout.fillHeight: true
                elide: Text.ElideLeft
            }

            TransformRow {
                Layout.fillHeight: true
                Layout.fillWidth: true
                valueToPresent: cameraComponent.orthographicPlanes.y
                onValueToPresentChanged: cameraComponent.setOrthographicPlane(1, valueToPresent)
            }
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 5
            height: 20

            MyTypes.Text {
                text: "Top:"
                Layout.preferredWidth: 60
                Layout.fillHeight: true
                elide: Text.ElideLeft
            }

            TransformRow {
                Layout.fillHeight: true
                Layout.fillWidth: true
                valueToPresent: cameraComponent.orthographicPlanes.z
                onValueToPresentChanged: cameraComponent.setOrthographicPlane(2, valueToPresent)
            }
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 5
            height: 20

            MyTypes.Text {
                text: "Bottom:"
                Layout.preferredWidth: 60
                Layout.fillHeight: true
                elide: Text.ElideLeft
            }

            TransformRow {
                Layout.fillHeight: true
                Layout.fillWidth: true
                valueToPresent: cameraComponent.orthographicPlanes.w
                onValueToPresentChanged: cameraComponent.setOrthographicPlane(3, valueToPresent)
            }
        }
    }
}
