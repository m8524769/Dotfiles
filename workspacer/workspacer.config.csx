#r "C:\Program Files\workspacer\workspacer.Shared.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.Bar\workspacer.Bar.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.ActionMenu\workspacer.ActionMenu.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.FocusIndicator\workspacer.FocusIndicator.dll"

using System;
using System.Diagnostics;
using workspacer;
using workspacer.Bar;
using workspacer.ActionMenu;
using workspacer.FocusIndicator;

Action<IConfigContext> doConfig = (context) =>
{
    // context.AddBar();
    // context.AddFocusIndicator();
    var actionMenu = context.AddActionMenu();

    context.WorkspaceContainer.CreateWorkspaces("1", "2", "3", "4", "5", "6", "7", "8", "9");

    // Custom Keybinds
    context.Keybinds.Subscribe(KeyModifiers.Alt, Keys.Q,
        () => context.Workspaces.FocusedWorkspace.CloseFocusedWindow(), "close focused window");

    context.Keybinds.Subscribe(KeyModifiers.Alt, Keys.H,
        () => context.Workspaces.FocusedWorkspace.FocusPreviousWindow(), "focus previous window");

    context.Keybinds.Subscribe(KeyModifiers.Alt, Keys.L,
        () => context.Workspaces.FocusedWorkspace.FocusNextWindow(), "focus next window");

    context.Keybinds.Subscribe(KeyModifiers.Alt | KeyModifiers.LShift, Keys.H,
        () => context.Workspaces.FocusedWorkspace.SwapFocusAndNextWindow(), "swap focus and next window");

    context.Keybinds.Subscribe(KeyModifiers.Alt | KeyModifiers.LShift, Keys.L,
        () => context.Workspaces.FocusedWorkspace.SwapFocusAndPreviousWindow(), "swap focus and previous window");

    context.Keybinds.Subscribe(KeyModifiers.Alt, Keys.Left,
        () => context.Workspaces.FocusedWorkspace.ShrinkPrimaryArea(), "shrink primary area");

    context.Keybinds.Subscribe(KeyModifiers.Alt, Keys.Right,
        () => context.Workspaces.FocusedWorkspace.ExpandPrimaryArea(), "expand primary area");

    context.Keybinds.Subscribe(KeyModifiers.Alt | KeyModifiers.LShift, Keys.Left,
        () => context.Workspaces.FocusedWorkspace.SwapFocusAndNextWindow(), "swap focus and next window");

    context.Keybinds.Subscribe(KeyModifiers.Alt | KeyModifiers.LShift, Keys.Right,
        () => context.Workspaces.FocusedWorkspace.SwapFocusAndPreviousWindow(), "swap focus and previous window");

    context.Keybinds.Subscribe(KeyModifiers.Alt | KeyModifiers.LControl, Keys.R,
        context.Restart, "restart workspacer");

    context.Keybinds.Subscribe(KeyModifiers.Alt, Keys.Enter,
        () => Process.Start("wt"), "start windows terminal");

    context.Keybinds.Subscribe(KeyModifiers.Alt | KeyModifiers.LControl, Keys.H,
        () => Process.Start("explorer"), "start file explorer");

    // context.Keybinds.Subscribe(KeyModifiers.Alt | KeyModifiers.LControl, Keys.V,
    //     () => Process.Start("gvim"), "start gVim");

    // context.Keybinds.Subscribe(KeyModifiers.Alt | KeyModifiers.LControl, Keys.C,
    //     () => Process.Start("chrome"), "start Chrome");
};
return doConfig;
