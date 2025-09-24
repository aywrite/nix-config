{ config, pkgs, ... }:

let
  # VS Code/Windsurf settings in the proper format
  settings = {
    # Editor settings
    "editor.lineNumbers" = "relative";
    "editor.cursorLine" = true;
    "editor.tabSize" = 2;
    "editor.insertSpaces" = true;
    "editor.rulers" = [ 80 100 ];
    "editor.wordWrap" = "off";
    "editor.renderWhitespace" = "all";
    "editor.minimap.enabled" = false;
    "editor.fontFamily" = "FiraCode Nerd Font";
    "editor.fontSize" = 12;
    "editor.fontLigatures" = true;

    # Files
    "files.trimTrailingWhitespace" = true;
    "files.insertFinalNewline" = true;

    # Terminal settings for Nix integration
    "terminal.integrated.fontFamily" = "FiraCode Nerd Font";
    "terminal.integrated.fontSize" = 12;
    "terminal.integrated.defaultProfile.osx" = "zsh";
    # Force interactive shell to load .zshrc properly
    "terminal.integrated.shellArgs.zsh" = [ "-i" ];
    # Set up the shell profile to ensure zshrc is loaded
    "terminal.integrated.profiles.osx" = {
      "zsh" = {
        "path" = "zsh";
        "args" = [ "-i" ];
      };
    };
    # Global environment variables for all Windsurf processes (including MCP servers)
    "terminal.integrated.inheritEnv" = true;

    # Set environment variables for the integrated terminal and child processes
    "terminal.integrated.env.osx" = {
      "DIRENV_LOG_FORMAT" = "";
      # Ensure Nix paths are available to all processes
      "NIX_PROFILES" = "/nix/var/nix/profiles/default $HOME/.nix-profile";
      "NIX_SSL_CERT_FILE" = "/nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt";
      "PATH" = "$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin";
    };

    # Workbench
    "workbench.colorTheme" = "Solarized Dark";
    "workbench.iconTheme" = "material-icon-theme";

    # Vim extension settings
    "vim.easymotion" = true;
    "vim.incsearch" = true;
    "vim.useSystemClipboard" = true;
    "vim.useCtrlKeys" = true;
    "vim.hlsearch" = true;
    "vim.leader" = "<space>";
    "vim.normalModeKeyBindingsNonRecursive" = [
      # File operations
      {
        "before" = [ "<leader>" "w" ];
        "commands" = [ "workbench.action.files.save" ];
      }
      {
        "before" = [ "<leader>" "q" ];
        "commands" = [ "workbench.action.closeActiveEditor" ];
      }
      # Navigation
      {
        "before" = [ "<leader>" "g" "d" ];
        "commands" = [ "editor.action.revealDefinition" ];
      }
      {
        "before" = [ "<leader>" "g" "r" ];
        "commands" = [ "editor.action.goToReferences" ];
      }
      {
        "before" = [ "<leader>" "g" "i" ];
        "commands" = [ "editor.action.goToImplementation" ];
      }
      # Search and replace
      {
        "before" = [ "<leader>" "f" ];
        "commands" = [ "editor.action.formatDocument" ];
      }
      {
        "before" = [ "<leader>" "r" ];
        "commands" = [ "editor.action.rename" ];
      }
    ];
    "vim.insertModeKeyBindings" = [
      {
        "before" = [ "j" "k" ];
        "after" = [ "<Esc>" ];
      }
    ];
    "vim.handleKeys" = {
      "<C-d>" = true;
      "<C-f>" = false; # Let VSCode handle find
      "<C-h>" = true;
      "<C-w>" = false; # Let VSCode handle window management
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
