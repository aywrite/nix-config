# windsurf.nix
{ config, pkgs, ... }:

let
  settingsPath = if pkgs.stdenv.isDarwin then
    "Library/Application Support/Windsurf/User/settings.json"
  else
    ".config/windsurf/settings.json";
in
{
  home.file.${settingsPath}.text = builtins.toJSON {
    theme = {
      name = "solarized-dark"; # Match your vim theme
    };
    editor = {
      font = {
        family = "FiraCode";
        size = 12;
      };
      vim = {
        enabled = true;
        useSystemClipboard = true;
        leader = "<Space>";
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
    terminal = {
      font = {
        family = "FiraCode";
        size = 12;
      };
      shell = {
        program = "zsh";
      };
    };
    workbench = {
      colorTheme = "Solarized Dark";
      iconTheme = "material-icon-theme";
    };
    window = {
      zoomLevel = 0;
      menuBarVisibility = "toggle";
    };
  };
}
