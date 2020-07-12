#r "C:\Program Files\workspacer\workspacer.Shared.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.Bar\workspacer.Bar.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.ActionMenu\workspacer.ActionMenu.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.FocusIndicator\workspacer.FocusIndicator.dll"

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using workspacer;
using workspacer.Bar;
using workspacer.Bar.Widgets;
using workspacer.ActionMenu;
using workspacer.FocusIndicator;

public class DefaultLayoutEngine : ILayoutEngine
{
    private readonly int _numInPrimary;
    private readonly double _primaryPercent;
    private readonly double _primaryPercentIncrement;

    private int _numInPrimaryOffset = 0;
    private double _primaryPercentOffset = 0;

    public DefaultLayoutEngine() : this(1, 0.5, 0.05) { }

    public DefaultLayoutEngine(int numInPrimary, double primaryPercent, double primaryPercentIncrement)
    {
        _numInPrimary = numInPrimary;
        _primaryPercent = primaryPercent;
        _primaryPercentIncrement = primaryPercentIncrement;
    }

    public string Name => "default";

    public IEnumerable<IWindowLocation> CalcLayout(IEnumerable<IWindow> windows, int spaceWidth, int spaceHeight)
    {
        var list = new List<IWindowLocation>();
        var numWindows = windows.Count();

        if (numWindows == 0)
            return list;

        int numInPrimary = Math.Min(GetNumInPrimary(), numWindows);

        int primaryWidth = (int)(spaceWidth * (_primaryPercent + _primaryPercentOffset));
        int primaryHeight = spaceHeight / numInPrimary;
        int height = spaceHeight / Math.Max(numWindows - numInPrimary, 1);

        // if there are more "primary" windows than actual windows,
        // then we want the pane to actually spread the entire width
        // of the working area
        if (numInPrimary >= numWindows)
        {
            primaryWidth = spaceWidth;
        }

        int secondaryWidth = spaceWidth - primaryWidth;

        for (var i = 0; i < numWindows; i++)
        {
            if (i < numInPrimary)
            {
                list.Add(new WindowLocation(-4, i * primaryHeight + 5, primaryWidth + 8, primaryHeight, WindowState.Normal));
            }
            else
            {
                list.Add(new WindowLocation(primaryWidth-8, (i - numInPrimary) * height + 5, secondaryWidth + 12, height, WindowState.Normal));
            }
        }
        return list;
    }

    public void ShrinkPrimaryArea()
    {
        _primaryPercentOffset -= _primaryPercentIncrement;
    }

    public void ExpandPrimaryArea()
    {
        _primaryPercentOffset += _primaryPercentIncrement;
    }

    public void ResetPrimaryArea()
    {
        _primaryPercentOffset = 0;
    }

    public void IncrementNumInPrimary()
    {
        _numInPrimaryOffset++;
    }

    public void DecrementNumInPrimary()
    {
        if (GetNumInPrimary() > 1)
        {
            _numInPrimaryOffset--;
        }
    }

    private int GetNumInPrimary()
    {
        return _numInPrimary + _numInPrimaryOffset;
    }
}

Action<IConfigContext> doConfig = (context) =>
{
    // context.AddBar(new BarPluginConfig() {
    //     BarTitle = "workspacer.Bar",
    //     BarHeight = 28,
    //     FontSize = 12,
    //     DefaultWidgetForeground = new Color(0xFF, 0xFF, 0xFF),
    //     DefaultWidgetBackground = new Color(0x80, 0x80, 0x80),
    //     Background = Color.Black,
    //     LeftWidgets = () => new IBarWidget[] { new WorkspaceWidget() },
    //     RightWidgets = () => new IBarWidget[] { new ActiveLayoutWidget() },
    // });

    // context.AddFocusIndicator(new FocusIndicatorPluginConfig() {
    //     BorderColor = Color.Aqua,
    //     BorderSize = 2,
    //     TimeToShow = 100,
    // });

    context.AddActionMenu(new ActionMenuPluginConfig() {
        RegisterKeybind = false,
    });

    context.DefaultLayouts = () => new ILayoutEngine[] { new DefaultLayoutEngine() };
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
