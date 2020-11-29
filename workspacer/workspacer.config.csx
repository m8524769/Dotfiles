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

public class FullscreenLayoutEngine : ILayoutEngine
{
    private readonly int _numInPrimary;
    private readonly double _primary;
    private readonly double _increment;

    private int _numInPrimaryOffset = 0;
    private double _offset = 0;

    public FullscreenLayoutEngine() : this(1, 0.5, 0.05) { }

    public FullscreenLayoutEngine(int numInPrimary, double primary, double increment)
    {
        _numInPrimary = numInPrimary;
        _primary = primary;
        _increment = increment;
    }

    public string Name => "fullscreen";

    public IEnumerable<IWindowLocation> CalcLayout(IEnumerable<IWindow> windows, int spaceWidth, int spaceHeight)
    {
        var windowLocations = new List<IWindowLocation>();
        var windowsCount = windows.Count();

        if (windowsCount == 0)
            return windowLocations;

        int numInPrimary = Math.Min(GetNumInPrimary(), windowsCount);

        int primaryWidth = (int)(spaceWidth * (_primary + _offset));
        int primaryHeight = spaceHeight / numInPrimary;
        int height = spaceHeight / Math.Max(windowsCount - numInPrimary, 1);

        if (numInPrimary >= windowsCount)
        {
            primaryWidth = spaceWidth;
        }

        int secondaryWidth = spaceWidth - primaryWidth;

        for (var i = 0; i < windowsCount; i++)
        {
            if (i < numInPrimary)
            {
                windowLocations.Add(new WindowLocation(0, 0, spaceWidth, spaceHeight, WindowState.Maximized));
            }
            else
            {
                windowLocations.Add(new WindowLocation(primaryWidth-8, (i - numInPrimary) * height + 5, secondaryWidth + 12, height, WindowState.Normal));
            }
        }
        return windowLocations;
    }

    public void ShrinkPrimaryArea()
    {
        _offset -= _increment;
    }

    public void ExpandPrimaryArea()
    {
        _offset += _increment;
    }

    public void ResetPrimaryArea()
    {
        _offset = 0;
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

public class DefaultLayoutEngine : ILayoutEngine
{
    private readonly int _numInPrimary;
    private readonly double _primary;
    private readonly double _increment;
    private readonly int _gap;

    private int _numInPrimaryOffset = 0;
    private double _offset = 0;

    public DefaultLayoutEngine() : this(1, 0.5, 0.05, 5) { }

    public DefaultLayoutEngine(int numInPrimary, double primary, double increment, int gap)
    {
        _numInPrimary = numInPrimary;
        _primary = primary;
        _increment = increment;
        _gap = gap;
    }

    public string Name => "default";

    public IEnumerable<IWindowLocation> CalcLayout(IEnumerable<IWindow> windows, int spaceWidth, int spaceHeight)
    {
        var windowLocations = new List<IWindowLocation>();
        var windowsCount = windows.Count();

        if (windowsCount == 0)
            return windowLocations;

        int numInPrimary = Math.Min(GetNumInPrimary(), windowsCount);

        int primaryWidth = (int)(spaceWidth * (_primary + _offset));
        int primaryHeight = spaceHeight / numInPrimary;
        int height = spaceHeight / Math.Max(windowsCount - numInPrimary, 1);

        // if there are more "primary" windows than actual windows,
        // then we want the pane to actually spread the entire width
        // of the working area
        if (numInPrimary >= windowsCount)
        {
            primaryWidth = spaceWidth;
        }

        int secondaryWidth = spaceWidth - primaryWidth;

        for (var i = 0; i < windowsCount; i++)
        {
            if (i < numInPrimary)
            {
                windowLocations.Add(new WindowLocation(
                    _gap,
                    i * primaryHeight + _gap,
                    primaryWidth - (_gap * 2),
                    primaryHeight - (_gap * 2),
                    WindowState.Normal
                ));
            }
            else
            {
                windowLocations.Add(new WindowLocation(
                    primaryWidth,
                    (i - numInPrimary) * height + _gap,
                    secondaryWidth - _gap,
                    height - (_gap * 2),
                    WindowState.Normal
                ));
            }
        }
        return windowLocations;
    }

    public void ShrinkPrimaryArea()
    {
        _offset -= _increment;
    }

    public void ExpandPrimaryArea()
    {
        _offset += _increment;
    }

    public void ResetPrimaryArea()
    {
        _offset = 0;
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
    KeyModifiers mod = KeyModifiers.LAlt;

    context.AddActionMenu(new ActionMenuPluginConfig() {
        RegisterKeybind = false,
    });

    // context.DefaultLayouts = () => new ILayoutEngine[] { new DefaultLayoutEngine() };
    // context.WorkspaceContainer.CreateWorkspaces("1", "2", "3", "4", "5", "6", "7", "8", "9");

    context.WorkspaceContainer.CreateWorkspace("1", new DefaultLayoutEngine());
    context.WorkspaceContainer.CreateWorkspace("2", new FullscreenLayoutEngine());
    context.WorkspaceContainer.CreateWorkspace("3", new DefaultLayoutEngine());
    context.WorkspaceContainer.CreateWorkspace("4", new DefaultLayoutEngine());
    context.WorkspaceContainer.CreateWorkspace("5", new DefaultLayoutEngine());
    context.WorkspaceContainer.CreateWorkspace("6", new DefaultLayoutEngine());
    context.WorkspaceContainer.CreateWorkspace("7", new DefaultLayoutEngine());
    context.WorkspaceContainer.CreateWorkspace("8", new DefaultLayoutEngine());

    // Custom Keybinds
    context.Keybinds.Unsubscribe(mod, Keys.Q);
    context.Keybinds.Subscribe(mod, Keys.Q,
        () => context.Workspaces.FocusedWorkspace.CloseFocusedWindow(), "close focused window");

    context.Keybinds.Unsubscribe(mod, Keys.H);
    context.Keybinds.Subscribe(mod, Keys.H,
        () => context.Workspaces.FocusedWorkspace.FocusPreviousWindow(), "focus previous window");

    context.Keybinds.Unsubscribe(mod, Keys.L);
    context.Keybinds.Subscribe(mod, Keys.L,
        () => context.Workspaces.FocusedWorkspace.FocusNextWindow(), "focus next window");

    context.Keybinds.Subscribe(mod | KeyModifiers.LShift, Keys.H,
        () => context.Workspaces.FocusedWorkspace.SwapFocusAndNextWindow(), "swap focus and next window");

    context.Keybinds.Subscribe(mod | KeyModifiers.LShift, Keys.L,
        () => context.Workspaces.FocusedWorkspace.SwapFocusAndPreviousWindow(), "swap focus and previous window");

    context.Keybinds.Unsubscribe(mod, Keys.Left);
    context.Keybinds.Subscribe(mod, Keys.Left,
        () => context.Workspaces.FocusedWorkspace.ShrinkPrimaryArea(), "shrink primary area");

    context.Keybinds.Unsubscribe(mod, Keys.Right);
    context.Keybinds.Subscribe(mod, Keys.Right,
        () => context.Workspaces.FocusedWorkspace.ExpandPrimaryArea(), "expand primary area");

    context.Keybinds.Subscribe(mod | KeyModifiers.LShift, Keys.Left,
        () => context.Workspaces.FocusedWorkspace.SwapFocusAndNextWindow(), "swap focus and next window");

    context.Keybinds.Subscribe(mod | KeyModifiers.LShift, Keys.Right,
        () => context.Workspaces.FocusedWorkspace.SwapFocusAndPreviousWindow(), "swap focus and previous window");

    context.Keybinds.Subscribe(mod | KeyModifiers.LControl, Keys.R,
        context.Restart, "restart workspacer");

    context.Keybinds.Unsubscribe(mod, Keys.Enter);
    context.Keybinds.Subscribe(mod, Keys.Enter,
        () => Process.Start("wt"), "start windows terminal");

    context.Keybinds.Subscribe(mod | KeyModifiers.LControl, Keys.H,
        () => Process.Start("explorer"), "start file explorer");

    // context.Keybinds.Subscribe(mod | KeyModifiers.LControl, Keys.V,
    //     () => Process.Start("gvim"), "start gVim");

    // context.Keybinds.Subscribe(mod | KeyModifiers.LControl, Keys.C,
    //     () => Process.Start("chrome"), "start Chrome");
};
return doConfig;
