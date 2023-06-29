import QtQuick
import QtQuick.Controls
import "../MyTypes" as MyTypes

Column {
    anchors.left: parent.left
    anchors.right: parent.right
    spacing: 5

    MyTypes.Text {
        id: tagText
        width: contentWidth
        height: 20
        verticalAlignment: Text.AlignVCenter
        text: "- Tag name:"
    }

    MyTypes.TextField {
        id: textEdit
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        height: 30
        text: entityList.getSelectedEntity().getComponent("TagComponent").name
        onEditingFinished: {
            entityList.getSelectedEntity().getComponent("TagComponent").name = text
            var index = entityList.model.index(entityList.currentIndex, 0)
            entityList.model.dataChanged(index, index, [0])
            focus = false
        }
    }
}