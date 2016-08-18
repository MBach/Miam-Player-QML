import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import Qt.labs.folderlistmodel 1.0

Page {
    id: fileSystemExplorer

    Component {
        id: fileDelegate
        Label {
            text: fileName
        }
    }
    FolderListModel {
        id: folderListModel
    }


    contentItem: Rectangle {
        color: appSettings.menuPaneColor
        anchors.fill: parent

        ListView {
            id: folderListView
            model: folderListModel
            delegate: fileDelegate
        }
    }
}
