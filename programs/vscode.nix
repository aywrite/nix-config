{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.vscode;

  # Common settings for all environments
  baseSettings = {
    # Vim settings
    "vim.easymotion" = true;
    "vim.incsearch" = true;
    "vim.useSystemClipboard" = true;
    "vim.useCtrlKeys" = true;
    "vim.hlsearch" = true;

    # Key bindings matching Neovim config
    "vim.insertModeKeyBindings" = [
      {
        "before" = [ "j" "k" ];
        "after" = [ "<Esc>" ];
      }
    ];

    "vim.normalModeKeyBindingsNonRecursive" = [
      # Space as leader
      {
        "before" = [ "<space>" ];
        "commands" = [ "workbench.action.showCommands" ];
      }
      # Testing shortcuts
      {
        "before" = [ "<leader>" "t" "n" ];
        "commands" = [ "testing.runTest" ];
      }
      {
        "before" = [ "<leader>" "t" "f" ];
        "commands" = [ "testing.runCurrentFile" ];
      }
      {
        "before" = [ "<leader>" "t" "a" ];
        "commands" = [ "testing.runAll" ];
      }
      # Code navigation
      {
        "before" = [ "<leader>" "g" "d" ];
        "commands" = [ "editor.action.revealDefinition" ];
      }
      {
        "before" = [ "<leader>" "g" "t" ];
        "commands" = [ "editor.action.goToTypeDefinition" ];
      }
      {
        "before" = [ "<leader>" "g" "i" ];
        "commands" = [ "editor.action.goToImplementation" ];
      }
      {
        "before" = [ "<leader>" "g" "r" ];
        "commands" = [ "editor.action.goToReferences" ];
      }
      # Formatting
      {
        "before" = [ "<leader>" "f" ];
        "commands" = [ "editor.action.formatDocument" ];
      }
      # File/buffer navigation
      {
        "before" = [ "<leader>" "<leader>" ];
        "commands" = [ "workbench.action.quickOpen" ];
      }
    ];

    "vim.normalModeKeyBindings" = [
      {
        "before" = [ "<Up>" ];
        "after" = [ "<Nop>" ];
      }
      {
        "before" = [ "<Down>" ];
        "after" = [ "<Nop>" ];
      }
      {
        "before" = [ "<Left>" ];
        "after" = [ "<Nop>" ];
      }
      {
        "before" = [ "<Right>" ];
        "after" = [ "<Nop>" ];
      }
    ];

    "vim.leader" = "<space>";

    # Preserve VS Code keybindings
    "vim.handleKeys" = {
      "<C-f>" = false;
      "<C-b>" = false;
      "<C-k>" = false;
      "<C-w>" = false;
    };

    # Editor settings matching Neovim
    "editor.fontFamily" = "FiraCode Nerd Font";
    "editor.fontSize" = 14;
    "editor.fontLigatures" = true;
    "editor.formatOnSave" = true;
    "editor.rulers" = [ 80 100 120 ];
    "editor.tabSize" = 2;
    "editor.insertSpaces" = true;
    "editor.autoIndent" = "advanced";
    "editor.renderWhitespace" = "boundary";
    "editor.lineNumbers" = "on";

    # Files
    "files.trimTrailingWhitespace" = true;
    "files.insertFinalNewline" = true;
    "files.trimFinalNewlines" = true;

    # Terminal
    "terminal.integrated.fontFamily" = "FiraCode Nerd Font";
    "terminal.integrated.fontSize" = 14;

    # Git
    "git.enableSmartCommit" = true;
    "git.confirmSync" = false;
    "git.autofetch" = true;

    # Python
    "python.formatting.provider" = "black";
    "python.linting.enabled" = true;
    "python.linting.flake8Enabled" = true;

    # Nix
    "nix.enableLanguageServer" = true;
    "[nix]"."editor.tabSize" = 2;

    # Theme (matching Solarized Dark)
    "workbench.colorTheme" = "Solarized Dark";
    "workbench.startupEditor" = "none";
    "workbench.colorCustomizations" = {
      "editorBracketMatch.background" = "#00000000";
      "editorBracketMatch.border" = "#2aa19899";
    };

    # Window
    "window.zoomLevel" = 0;

    # Telemetry
    "telemetry.telemetryLevel" = "off";
  };

  # Role-specific settings
  roleSettings =
    if config.role.vscodeSettings != null
    then config.role.vscodeSettings
    else { };

  # Merge base and role settings
  finalSettings = baseSettings // roleSettings;

  # Helper function to create VSCode settings files
  mkVSCodeSettings = isWSL:
    let
      baseFiles = {
        ".vscode/settings.json".text = builtins.toJSON finalSettings;
      };
      wslFiles = {
        ".vscode-server/data/Machine/settings.json".text = builtins.toJSON finalSettings;
        ".vscode-server/data/User/settings.json".text = builtins.toJSON finalSettings;
      };
    in
    if isWSL
    then baseFiles // wslFiles
    else baseFiles;
in
{
  options.role = {
    isWSL = mkOption {
      type = types.bool;
      default = false;
      description = "Whether this configuration is for WSL";
    };

    vscodeSettings = mkOption {
      type = types.nullOr (types.attrsOf types.anything);
      default = null;
      description = "Role-specific VSCode settings";
      example = literalExpression ''
        {
          "window.zoomLevel" = 1;
          "workbench.colorTheme" = "Monokai";
        }
      '';
    };
  };

  config = {
    # Create VSCode settings files based on WSL status
    home.file = mkVSCodeSettings config.role.isWSL;
  };
}
