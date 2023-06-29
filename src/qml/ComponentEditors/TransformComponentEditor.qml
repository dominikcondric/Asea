import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../MyTypes" as MyTypes

Column {
    id: root
    spacing: 10
    property var transformComponent: entityList.getSelectedEntity().getComponent("TransformComponent")

    Column {
        anchors.left: parent.left
        width: parent.width * 0.9
        spacing: 5

        MyTypes.Text {
            anchors.left: parent.left
            width: contentWidth
            height: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: "- Translation: "
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 10
            spacing: 5
            height: 20

            MyTypes.Text {
                text: "X:"
                horizontalAlignment: Text.AlignHCenter
                Layout.preferredWidth: 40
                Layout.fillHeight: true
            }

            TransformRow {
                Layout.fillHeight: true
                Layout.fillWidth: true
                min: -1e10
                max: 1e10
                valueToPresent: root.transformComponent.translation.x
                onValueToPresentChanged: root.transformComponent.translation = Qt.vector3d(valueToPresent - root.transformComponent.translation.x, 0., 0.)
            }
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 10
            spacing: 5
            height: 20

            MyTypes.Text {
                text: "Y:"
                horizontalAlignment: Text.AlignHCenter
                Layout.preferredWidth: 40
                Layout.fillHeight: true
            }

            TransformRow {
                Layout.fillHeight: true
                Layout.fillWidth: true
                min: -1e10
                max: 1e10
                valueToPresent: root.transformComponent.translation.y
                onValueToPresentChanged: root.transformComponent.translation = Qt.vector3d(0., valueToPresent - root.transformComponent.translation.y, 0.)
            }
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 10
            spacing: 5
            height: 20

            MyTypes.Text {
                text: "Z:"
                horizontalAlignment: Text.AlignHCenter
                Layout.preferredWidth: 40
                Layout.fillHeight: true
            }

            TransformRow {
                Layout.fillHeight: true
                Layout.fillWidth: true
                min: -1e10
                max: 1e10
                valueToPresent: root.transformComponent.translation.z
                onValueToPresentChanged: root.transformComponent.translation = Qt.vector3d(0., 0., valueToPresent - root.transformComponent.translation.z)
            }
        }
    }


    Column {
        anchors.left: parent.left
        width: parent.width * 0.9
        spacing: 5

        MyTypes.Text {
            anchors.left: parent.left
            width: contentWidth
            height: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: "- Scale: "
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 10
            spacing: 5
            height: 20

            MyTypes.Text {
                text: "X:"
                horizontalAlignment: Text.AlignHCenter
                Layout.preferredWidth: 40
                Layout.fillHeight: true
            }

            TransformRow {
                id: scaleX
                Layout.fillHeight: true
                Layout.fillWidth: true
                min: 0.01
                max: 100
                transformFactor: 0.01
                valueToPresent: root.transformComponent.scale.x
                onValueToPresentChanged: root.transformComponent.scale = Qt.vector3d(valueToPresent / root.transformComponent.scale.y, 1., 1.)
            }
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 10
            spacing: 5
            height: 20

            MyTypes.Text {
                text: "Y:"
                horizontalAlignment: Text.AlignHCenter
                Layout.preferredWidth: 40
                Layout.fillHeight: true
            }

            TransformRow {
                id: scaleY
                Layout.fillHeight: true
                Layout.fillWidth: true
                min: 0.01
                max: 100
                transformFactor: 0.01
                valueToPresent: root.transformComponent.scale.y
                onValueToPresentChanged: root.transformComponent.scale = Qt.vector3d(1., valueToPresent / root.transformComponent.scale.y, 1.)
            }
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 10
            spacing: 5
            height: 20

            MyTypes.Text {
                text: "Z:"
                horizontalAlignment: Text.AlignHCenter
                Layout.preferredWidth: 40
                Layout.fillHeight: true
            }

            TransformRow {
                id: scaleZ
                Layout.fillHeight: true
                Layout.fillWidth: true
                min: 0.01
                max: 100
                transformFactor: 0.01
                valueToPresent: root.transformComponent.scale.z
                onValueToPresentChanged: root.transformComponent.scale = Qt.vector3d(1., 1., valueToPresent / root.transformComponent.scale.z)
            }
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 10
            spacing: 5
            height: 20

            MyTypes.Text {
                text: "XYZ:"
                horizontalAlignment: Text.AlignHCenter
                Layout.preferredWidth: 40
                Layout.fillHeight: true
            }

            TransformRow {
                Layout.fillHeight: true
                Layout.fillWidth: true
                min: 0.01
                max: 100
                transformFactor: 0.01
                valueToPresent: root.transformComponent.scale.x
                onValueToPresentChanged: {
                    root.transformComponent.scale = Qt.vector3d(valueToPresent / root.transformComponent.scale.x, valueToPresent / root.transformComponent.scale.x, valueToPresent / root.transformComponent.scale.x)
                    scaleX.valueToPresent = valueToPresent
                    scaleY.valueToPresent = valueToPresent
                    scaleZ.valueToPresent = valueToPresent
                }
            }
        }
    }


    Column {
        anchors.left: parent.left
        width: parent.width * 0.9
        spacing: 5

        MyTypes.Text {
            anchors.left: parent.left
            width: contentWidth
            height: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: "- Rotation: "
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 10
            spacing: 5
            height: 20

            MyTypes.Text {
                text: "X:"
                horizontalAlignment: Text.AlignHCenter
                Layout.preferredWidth: 40
                Layout.fillHeight: true
            }

            TransformRow {
                Layout.fillHeight: true
                Layout.fillWidth: true
                min: 0
                max: 359
                transformFactor: 5.0
                valueToPresent: root.transformComponent.rotation.x
                onValueToPresentChanged: root.transformComponent.setRotation(valueToPresent - root.transformComponent.rotation.x, Qt.vector3d(1., 0., 0.))
            }
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 10
            spacing: 5
            height: 20

            MyTypes.Text {
                text: "Y:"
                horizontalAlignment: Text.AlignHCenter
                Layout.preferredWidth: 40
                Layout.fillHeight: true
            }

            TransformRow {
                Layout.fillHeight: true
                Layout.fillWidth: true
                min: 0
                max: 359
                transformFactor: 5.0
                valueToPresent: root.transformComponent.rotation.y
                onValueToPresentChanged: root.transformComponent.setRotation(valueToPresent - root.transformComponent.rotation.y, Qt.vector3d(0., 1., 0.))
            }
        }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 10
            spacing: 5
            height: 20

            MyTypes.Text {
                text: "Z:"
                horizontalAlignment: Text.AlignHCenter
                Layout.preferredWidth: 40
                Layout.fillHeight: true
            }

            TransformRow {
                Layout.fillHeight: true
                Layout.fillWidth: true
                min: 0
                max: 359
                transformFactor: 5.0
                valueToPresent: root.transformComponent.rotation.z
                onValueToPresentChanged: root.transformComponent.setRotation(valueToPresent - root.transformComponent.rotation.z, Qt.vector3d(0., 0., 1.))
            }
        }
    }
}