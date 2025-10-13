# In your home.nix

programs.fastfetch = {
  enable = true;
  settings = {

    logo = {
      source = ''$(find "${XDG_CONFIG_HOME:-$HOME/.config}/fastfetch/pngs/" -name "*.png" | sort -R | head -1)'';
      height = 10;
      padding = {
        top = 4;
        right = 4;
        left = 4;
      };
    };

    display = {
      separator = " ";
    };

    modules = [
      "break"
      "break"
      {
        type = "custom";
        key = "  モニカの NixOS ライス  ";
      }
      {
        type = "custom";
        keyColor = "#b4befe";
        key = "┌──────────────────────────────────┐";
        value = "";
      }
      "break"
      {
        type = "os";
        key = "オーエス";
        keyColor = "#7CBFFF";
      }
      {
        type = "kernel";
        key = "カーネル";
        keyColor = "#7CBFFF";
      }
      {
        type = "shell";
        key = "シェル";
        keyColor = "#C8C8C8";
      }
      {
        type = "terminal";
        key = "ターミナル";
        keyColor = "#C8C8C8";
      }
      {
        type = "uptime";
        key = "アップタイム";
        keyColor = "#FFC95D";
      }
      {
        type = "memory";
        key = "メモリ";
        keyColor = "#FFC95D";
      }
      {
        type = "battery";
        key = " ";
        keyColor = "#008000";
      }
      "break"
      {
        type = "custom";
        keyColor = "#b4befe";
        key = "└─────────────────────────────────┘";
        value = "";
      }
      {
        paddingLeft = 10;
        type = "colors";
        symbol = "circle";
      }
      "break"
      "break"
    ];
  };
};
