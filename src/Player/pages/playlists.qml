import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import Qt.labs.folderlistmodel 1.0

Pane {
    id: playlists
    bottomPadding: 0
    anchors.top: stackView.top
    anchors.left: stackView.left
    anchors.right: stackView.right
    anchors.bottom: stackView.bottom

    ListModel {
        id: libraryModel
        ListElement {
            title: "A Masterpiece"
            author: "Gabriel"
        }
        ListElement {
            title: "Brilliance"
            author: "Jens"
        }
        ListElement {
            title: "Outstanding"
            author: "Frederik"
        }
    }

    SplitView {

        id: mainRow
        anchors.fill: parent

        ColumnLayout {
            id: leftColumnLayout
            spacing: 0

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            Layout.fillHeight: true
            Layout.fillWidth: false

            Layout.preferredWidth: 300
            width: 300

            TabBar {
                id: leftTabBar
                Layout.fillWidth: true
                Layout.preferredWidth: 300

                anchors.left: parent.left
                anchors.top: parent.top
                anchors.right: parent.right

                TabButton {
                    id: libraryTabButton
                    text: qsTr("Library")
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    width: leftTabBar.width / 2
                }
                TabButton {
                    text: qsTr("File Explorer")
                    anchors.top: parent.top
                    anchors.topMargin: 0
                }
            }

            StackLayout {
                anchors.left: parent.left
                anchors.top: leftTabBar.bottom
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                width: parent.width
                currentIndex: leftTabBar.currentIndex

                Library {
                    anchors.fill: parent
                }

                FileSystemExplorer {}
            }
        }

        ListView {
            id: playlistsView
            Layout.preferredWidth: 600
            snapMode: ListView.SnapToItem
            model: libraryModel
            anchors.left: leftColumnLayout.right
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            Layout.fillHeight: true
            Layout.fillWidth: false

            delegate: ItemDelegate {
                id: playlistItemDelegate
                width: playlistsView.width
                RowLayout {
                    width: playlistsView.width
                    Label {
                        text: model.title
                    }
                }
                highlighted: ListView.isCurrentItem
            }

            ScrollBar.vertical: ScrollBar {}
        }
    }
}
