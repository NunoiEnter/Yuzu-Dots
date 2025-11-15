{ config, pkgs, ... }:

let
  waybarConfig = {
    layer = "top";
    position = "top";
    height = 32;
    spacing = 0;
    marginTop = 0;
    marginLeft = 0;
    marginRight = 0;

    modulesLeft = [ "custom/butterfly" "niri/workspaces" "niri/window" ];
    modulesCenter = [ "clock" ];
    modulesRight = [ "pulseaudio" "pulseaudio#microphone" "network" "battery" ];

    custom = {
      butterfly = {
        format = "";
        tooltip = false;
        onClick = "fuzzle";
      };
    };

    niri = {
      workspaces = {
        format = "{icon}";
        formatIcons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          default = "○";
        };
        onClick = "activate";
      };
      window = {
        format = "{}";
        maxLength = 50;
        rewrite = {
          "(.*) — Mozilla Firefox" = "🌸 $1";
          "(.*)Mozilla Firefox" = "🌸 Firefox";
          "(.*) - Visual Studio Code" = "💻 $1";
          "(.*)Visual Studio Code" = "💻 VSCode";
        };
      };
    };

    clock = {
      interval = 1;
      format = "{:%H:%M:%S}";
      formatAlt = "{:%Y-%m-%d %a}";
      tooltipFormat = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode = "month";
        modeMonCol = 3;
        weeksPos = "right";
        onScroll = 1;
        format = {
          months = "<span color='#b4befe'><b>{}</b></span>";
          days = "<span color='#cdd6f4'><b>{}</b></span>";
          weeks = "<span color='#94e2d5'><b>W{}</b></span>";
          weekdays = "<span color='#f9e2af'><b>{}</b></span>";
          today = "<span color='#f38ba8'><b><u>{}</u></b></span>";
        };
      };
    };

    pulseaudio = {
      format = "{icon} {volume}%";
      formatMuted = " Muted";
      formatIcons = {
        headphone = "󰋋 ";
        "hands-free" = "󰋋 ";
        headset = "󰋋 ";
        phone = " ";
        portable = " ";
        car = " ";
        default = [ "󰕿 " " " " " ];
      };
      scrollStep = 5;
      onClick = "pamixer --toggle-mute";
      onClickRight = "pavucontrol";
      tooltipFormat = "{desc}\n{volume}%";
    };

    "pulseaudio#microphone" = {
      format = "{format_source}";
      formatSource = " {volume}%";
      formatSourceMuted = "    Muted";
      onClick = "pamixer --default-source --toggle-mute";
      onClickRight = "pavucontrol";
      onScrollUp = "pamixer --default-source --increase 5";
      onScrollDown = "pamixer --default-source --decrease 5";
      scrollStep = 5;
      tooltipFormat = "Microphone: {volume}%";
    };

    network = {
      formatWifi = "    {essid}";
      formatEthernet = "🌐 {ipaddr}";
      formatDisconnected = "❌ Offline";
      tooltipFormatWifi = "{essid} ({signalStrength}%)\n{ipaddr}/{cidr}";
      tooltipFormatEthernet = "{ifname}\n{ipaddr}/{cidr}";
      onClick = "nm-connection-editor";
      interval = 5;
    };

    battery = {
      interval = 10;
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{icon} {capacity}%";
      formatCharging = "⚡ {capacity}%";
      formatPlugged = "⚡ {capacity}%";
      formatIcons = [ "  " "  " "  " "  " "  " ];
      tooltipFormat = "{timeTo}\n{capacity}% - {power}W";
    };
  };
in
{
  services.waybar = {
    enable = true;
    config = waybarConfig;
    extraConfig = ''
      /* Custom CSS */
      ${builtins.readFile ./waybar.css}
    '';
  };
}

