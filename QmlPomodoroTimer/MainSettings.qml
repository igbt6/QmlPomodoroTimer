import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
import QtQuick.Controls.Styles 1.4
import "."

Item {
    id: settings
    width: parent.width
    height: parent.height
    SystemPalette { id: palette }
    clip: true

    function saveSettings()
    {
        GlobalSettings.main.autoStartOfNextInterval = automaticStartOfnextInterval.checked
        GlobalSettings.main.pomodoroIntervalTimeMin = pomodoroAlarmValue.min
        GlobalSettings.main.pomodoroIntervalTimeSec = pomodoroAlarmValue.sec
        GlobalSettings.main.shortBreakIntervalTimeMin = shortBreakAlarmValue.min
        GlobalSettings.main.shortBreakIntervalTimeSec = shortBreakAlarmValue.sec
        GlobalSettings.main.longBreakIntervalTimeMin = longBreakAlarmValue.min
        GlobalSettings.main.longBreakIntervalTimeSec = longBreakAlarmValue.sec
        GlobalSettings.main.countModeIdx = countMode.currentIndex
        GlobalSettings.main.countMode = countMode.textAt(countMode.currentIndex)
        GlobalSettings.main.alarmVolume = alarmVolume.value
    }

    ScrollView {
        id: scrollView
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: bottomBar.top
            leftMargin: 12
        }

        ColumnLayout {
            spacing: 10

            Item {
                Layout.preferredHeight: 1
            }

            Label {
                font.bold: true
                text: "Main Settings"
            }

            CheckBox {
                id: automaticStartOfnextInterval
                text: "Autostart of next interval"
                checked: GlobalSettings.main.autoStartOfNextInterval
            }
            RowLayout {
                Label {
                    text: "Counter direction: "
                }
                ComboBox {
                    id: countMode
                    currentIndex: GlobalSettings.main.countModeIdx
                    model: ListModel {
                        id: cbItems
                        ListElement { text: "UP"; color: "Yellow" }
                        ListElement { text: "DOWN"; color: "Green" }
                    }
                    width: 200
                }
            }
            ColumnLayout
            {
                spacing: 40
                RowLayout
                {
                    MainSettingsIntervalTime {
                        id: pomodoroAlarmValue
                        min: GlobalSettings.main.pomodoroIntervalTimeMin
                        sec: GlobalSettings.main.pomodoroIntervalTimeSec
                        name: "Pomodoro alarm time"
                    }
                 }
                RowLayout
                {
                    MainSettingsIntervalTime {
                        id: shortBreakAlarmValue
                        min: GlobalSettings.main.shortBreakIntervalTimeMin
                        sec: GlobalSettings.main.shortBreakIntervalTimeSec
                        name: "Short break alarm time"
                    }
                }
                RowLayout
                {
                    MainSettingsIntervalTime {
                        id: longBreakAlarmValue
                        min: GlobalSettings.main.longBreakIntervalTimeMin
                        sec: GlobalSettings.main.longBreakIntervalTimeSec
                        name: "Long break alarm time"
                    }
                }
                RowLayout {
                    spacing: 40
                    Label {
                        text: "Alarm volume: "
                    }
                    Slider {
                        id: alarmVolume
                        value: GlobalSettings.main.alarmVolume
                        maximumValue: 100
                        width: 200
                        stepSize : 1
                        style: SliderStyle {
                            groove: Rectangle {
                                implicitWidth: 200
                                implicitHeight: 8
                                color: "gray"
                                radius: 8
                            }
                            handle: Rectangle {
                                anchors.centerIn: parent
                                color: control.pressed ? "white" : "lightgreen"
                                border.color: "gray"
                                border.width: 1
                                implicitWidth: 30
                                implicitHeight: 30
                                radius: 13
                                Text
                                {
                                    anchors.centerIn: parent
                                    text: alarmVolume.value
                                    font.pointSize: 10
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: bottomBar
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: buttonRow.height * 1.2
        color: Qt.darker(palette.window, 1.1)
        border.color: Qt.darker(palette.window, 1.3)
        Row {
            id: buttonRow
            spacing: 6
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 12
            width: parent.width
            Button {
                text: "Save"
                anchors.verticalCenter: parent.verticalCenter
                onClicked:
                {
                    saveSettings()
                }
            }
            Button {
                text: "Close"
                anchors.verticalCenter: parent.verticalCenter
                onClicked: close()
            }
        }
    }
}
