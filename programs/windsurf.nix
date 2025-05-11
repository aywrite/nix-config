{ config, pkgs, ... }:

let
  settings = {
    theme = {
      name = "solarized-dark"; # Match your vim theme
    };
    terminal = {
      font = {
        family = "FiraCode";
        size = 12;
      };
      shell = {
        program = "zsh";
      };
      defaultProfile = "zsh";
    };
    vim = {
      enabled = true;
      useSystemClipboard = true;
      leader = "<Space>";
      normalModeKeysNonRepeat = false; # Enable key repeat for normal mode
      insertModeKeyBindings = [
        {
          before = [ "j" "k" ];
          after = [ "<Esc>" ];
        }
      ];
      normalModeKeyBindings = [
        # File operations
        {
          before = [ "<leader>" "w" ];
          commands = [ "workbench.action.files.save" ];
        }
        {
          before = [ "<leader>" "q" ];
          commands = [ "workbench.action.closeActiveEditor" ];
        }
        # Navigation
        {
          before = [ "<leader>" "gd" ];
          commands = [ "editor.action.revealDefinition" ];
        }
        {
          before = [ "<leader>" "gr" ];
          commands = [ "editor.action.goToReferences" ];
        }
        {
          before = [ "<leader>" "gi" ];
          commands = [ "editor.action.goToImplementation" ];
        }
        # Search and replace
        {
          before = [ "<leader>" "f" ];
          commands = [ "editor.action.formatDocument" ];
        }
        {
          before = [ "<leader>" "r" ];
          commands = [ "editor.action.rename" ];
        }
      ];
      visualModeKeyBindings = [ ];
      handleKeys = {
        "<C-d>" = true;
        "<C-f>" = false; # Let VSCode handle find
        "<C-h>" = true;
        "<C-w>" = false; # Let VSCode handle window management
      };
    };
    editor = {
      font = {
        family = "FiraCode";
        size = 12;
      };
      settings = {
        "editor.lineNumbers" = "relative";
        "editor.cursorLine" = true;
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;
        "editor.rulers" = [ 80 100 ];
        "editor.wordWrap" = "off";
        "editor.renderWhitespace" = "all";
        "editor.minimap.enabled" = false;
        "files.trimTrailingWhitespace" = true;
        "files.insertFinalNewline" = true;
      };
    };
    workbench = {
      colorTheme = "Solarized Dark";
      iconTheme = "material-icon-theme";
    };
  };

  wslSettingsPath = ".local/share/windsurf/settings.json";
  windowsSettingsPath = "AppData/Roaming/Windsurf/User/settings.json";
  linuxSettingsPath = ".config/windsurf/settings.json";
  darwinSettingsPath = "Library/Application Support/Windsurf/User/settings.json";

  settingsJson = builtins.toJSON settings;
in
{
  home.file =
    if pkgs.stdenv.isDarwin then {
      ${darwinSettingsPath}.text = settingsJson;
    } else if config.role.isWSL then {
      ${wslSettingsPath}.text = settingsJson;
      ${windowsSettingsPath}.text = settingsJson;
    } else {
      ${linuxSettingsPath}.text = settingsJson;
    };
}
