import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

Item {
    id: root
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(root.QsWindow.window?.screen)
    readonly property HyprlandToplevel activeWindow: Hyprland.activeToplevel
    property string activeWindowAddress: activeWindow?.address
    property bool focusingThisMonitor: monitor.focused
    property var biggestWindow: HyprlandData.biggestWindowForWorkspace(Hyprland.focusedWorkspace.id)

    implicitWidth: colLayout.implicitWidth

    ColumnLayout {
        id: colLayout

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: -4

        StyledText {
            Layout.fillWidth: true
            font.pixelSize: Appearance.font.pixelSize.smaller
            color: Appearance.colors.colSubtext
            elide: Text.ElideRight
            text: root.focusingThisMonitor && root.activeWindow?.activated && root.biggestWindow ? root.activeWindow?.wayland?.appId : (root.biggestWindow?.class) ?? Translation.tr("Desktop")
        }

        StyledText {
            Layout.fillWidth: true
            font.pixelSize: Appearance.font.pixelSize.small
            color: Appearance.colors.colOnLayer0
            elide: Text.ElideRight
            text: root.focusingThisMonitor && root.activeWindow?.activated && root.biggestWindow ? root.activeWindow?.wayland?.title : (root.biggestWindow?.title) ?? `${Translation.tr("Workspace")} ${root.monitor?.activeWorkspace?.id ?? 1}`
        }
    }
}
