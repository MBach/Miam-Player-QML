import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtQuick.Controls.Material 2.0
import QtQuick.Dialogs 1.2

Pane {
    id: settingsPane
    //anchors.fill: parent
    anchors.left: stackView.left
    anchors.right: stackView.right

    ButtonGroup {
        id: styleBG
    }

    ButtonGroup {
        id: modeBG
    }

    TabBar {
        id: settingsTabBar
        z: 2
        Layout.fillWidth: true

        currentIndex: stackLayoutSettings.currentIndex

        anchors.left: parent.left
        anchors.right: parent.right

        TabButton {
            id: generalSettingsTabButton
            text: qsTr("General settings")
            font.pointSize: 16
            anchors.left: parent.left
            anchors.top: parent.top
            width: settingsTabBar.width / 2
        }
        TabButton {
            text: qsTr("Theme")
            font.pointSize: 16
            anchors.top: parent.top
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.music
        selectFolder: true
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrl)
            appSettings.musicLocations.push(fileDialog.fileUrl)
        }
        onRejected: {
            console.log("Canceled")
        }
    }

    StackLayout {
        id: stackLayoutSettings
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.top: settingsTabBar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        currentIndex: settingsTabBar.currentIndex

        ColumnLayout {
            id: generalSettingsColumnLayout
            Label {
                id: musicLocationLabel
                text: qsTr("Music locations")
                font.pointSize: 16
            }

            Flow {
                anchors.left: parent.left
                anchors.right: parent.right
                Button {
                    id: addMusicLocation
                    text: "+"
                    font.pointSize: 22

                    background: Rectangle {
                        implicitWidth: 150
                        implicitHeight: 75
                        opacity: 0.3
                        color: appSettings.menuPaneColor
                        border.color: addMusicLocation.down ? Material.accent : Material.foreground
                        border.width: 2
                    }
                    onClicked: {
                        fileDialog.open()
                    }
                }

                Repeater {
                    model: appSettings.musicLocations.size
                    Rectangle {
                        width: 150
                        height: 75
                        color: appSettings.menuPaneColor
                        border.color: Material.foreground
                        border.width: 2
                        Label {
                            text: appSettings.musicLocations[index]
                            anchors.fill: parent
                        }
                    }
                }
            }
        }

        Flickable {
            id: flickable
            anchors.top: generalSettingsColumnLayout.bottom
            anchors.bottom: parent.bottom
            Layout.fillWidth: true
            contentHeight: themeColumnLayout.height
            contentWidth: parent.width
            interactive: true

            ColumnLayout {
                id: themeColumnLayout
                anchors.fill: parent
                Label {
                    id: styleLabel
                    text: qsTr("Style")
                    font.pointSize: 16
                }
                Label {
                    id: styleAppliedAfterRestartLabel
                    visible: appSettings.style !== styleBG.checkedButton.text
                    text: qsTr("Style will be updated next time you will launch the App")
                }
                RadioButton {
                    checked: appSettings.style === "Material"
                    text: "Material"
                    ButtonGroup.group: styleBG
                    onClicked: {
                        appSettings.style = "Material"
                    }
                }
                RadioButton {
                    checked: appSettings.style === "Universal"
                    text: "Universal"
                    ButtonGroup.group: styleBG
                    onClicked: {
                        appSettings.style = "Universal"
                    }
                }
                Label {
                    id: modeLabel
                    text: qsTr("Mode")
                    font.pointSize: 16
                }
                RadioButton {
                    text: qsTr("Light")
                    checked: appSettings.theme === "Light"
                    ButtonGroup.group: modeBG
                    onClicked: {
                        appSettings.theme = "Light"
                        appSettings.background = "white"
                        appSettings.menuPaneColor = "#eeeeee"
                    }
                }
                RadioButton {
                    text: qsTr("Dark")
                    checked: appSettings.theme === "Dark"
                    ButtonGroup.group: modeBG
                    onClicked: {
                        appSettings.theme = "Dark"
                        appSettings.background = "black"
                        appSettings.menuPaneColor = "#171717"
                    }
                }
                RadioButton {
                    enabled: false
                    text: qsTr("Use system theme")
                    ButtonGroup.group: modeBG
                }
                Label {
                    id: customizeColorsLabel
                    text: qsTr("Customize colors")
                    font.pointSize: 16
                }
                Label {
                    id: accentColorLabel
                    text: qsTr("Accent")
                    font.pointSize: 14
                }
                Flow {
                    id: accentFlow
                    anchors.margins: 10
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 10
                    Repeater {
                        model: 19
                        Rectangle {
                            width: 50
                            height: 50
                            color: Material.color(index)
                            border.width: Qt.colorEqual(Material.color(index), appSettings.accent) ? 2 : 0
                            border.color: Material.foreground

                            MouseArea {
                                id: mouseAreaAccent
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    parent.border.width = 2
                                    parent.border.color = Material.foreground
                                }
                                onExited: parent.border.width = Qt.colorEqual(Material.color(index), appSettings.accent) ? 2 : 0
                                onClicked: {
                                    appSettings.accent = parent.color
                                }
                            }
                        }
                    }
                }

                Label {
                    id: primaryColorLabel
                    anchors.topMargin: 10
                    anchors.top: accentFlow.bottom
                    text: qsTr("Primary")
                    font.pointSize: 14
                }

                Flow {
                    id: primaryFlow
                    anchors.margins: 10
                    anchors.top: primaryColorLabel.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 10
                    Repeater {
                        model: 19
                        Rectangle {
                            width: 50
                            height: 50
                            color: Material.color(index)
                            border.width: Qt.colorEqual(Material.color(index), appSettings.primary) ? 2 : 0
                            border.color: Material.foreground

                            MouseArea {
                                id: mouseAreaPrimary
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    parent.border.width = 2
                                    parent.border.color = Material.foreground
                                }
                                onExited: {
                                    parent.border.width = Qt.colorEqual(Material.color(index), appSettings.primary) ? 2 : 0
                                }
                                onClicked: appSettings.primary = parent.color
                            }
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        console.log(appSettings.musicLocations)
    }
}
