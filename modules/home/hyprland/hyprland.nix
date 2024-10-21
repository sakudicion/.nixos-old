{ config, pkgs, ... }:

{

	home.packages = [
		pkgs.wlogout
		pkgs.rofi
		pkgs.xdg-user-dirs
		pkgs.polkit_gnome
		pkgs.kdePackages.polkit-kde-agent-1
		pkgs.bemoji
		pkgs.wl-clipboard
		pkgs.gnome-tweaks
		pkgs.hyprshot

		# Theme
		#pkgs.qogir-theme
		#pkgs.qogir-icon-theme
	];

	wayland.windowManager.hyprland = {
	      enable = true;
	      settings = {
	        # Initial config
	        "$mod" = "SUPER";
	        "$terminal" = "kitty";
	        "$fileManager" = "thunar";
	        "$menu" = "rofi -config ~/.nixos/modules/home/hyprland/rice/rofi/config.rasi -show drun";
	        "$taskswitcher" = "rofi -show window";
		"$browser" = "firefox";
		"$emojiselector" = "bemoji";
		"$power" = "wlogout";

		env = [
			"HYPRCURSOR_THEME,breeze-hacked"
			"HYPRCURSOR_SIZE,8"
			"LIBVA_DRIVER_NAME,nvidia"
			"XDG_SESSION_TYPE,wayland"
			"GBM_BACKEND,nvidia-drm"
			"__GLX_VENDOR_LIBRARY_NAME,nvidia"
		];

		cursor = {
			no_hardware_cursors = true;
		};
	
	        # Autostart
	
	        exec-once = [
	          "/usr/lib/polkit-kde-authentication-agent-1"
	          "/usr/lib/polkit-gnome"
	          "systemctl --user import-environment &"
	          "hash dbus-update-activation-environment 2>/dev/null &"
	          "dbus-update-activation-environment --systemd &"
	          "swww-daemon &"
		  "swww img ~/.nixos/modules/home/hyprland/rice/wallpapers/2.jpg &"
		  "ags -c ~/.nixos/modules/home/hyprland/rice/ags/ &"
		];
	        
	        # Looks
	        general = {
	          border_size = 0;
	          gaps_in = 2;
	          gaps_out = 5;
	          allow_tearing = true;
	          resize_on_border = true;
	          "col.active_border" = "rgba(799fe0ff)";
	          "col.inactive_border" = "rgba(595959aa)";
	          layout = "dwindle";
	        };
	        
	        animations = {
	        	enabled = true;
	        	bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
			};

		animations.animation = [
			"windows, 1, 7, myBezier"
			"windowsOut, 1, 7, default, popin 80%"
			"border, 1, 10, default"
			"borderangle, 1, 8, default"
			"fade, 1, 7, default"
			"workspaces, 1, 6, default"
		];
	        
	        decoration.blur = {
	          	enabled = true;
	          	size = 3;
	          	passes = 1;
	          	vibrancy = 0.1696;
	        };	

		decoration = {
			rounding = 10;
    			active_opacity = 1.0;
   			inactive_opacity = 1.0;
			drop_shadow = true;
    			shadow_range = 4;
    			shadow_render_power = 3;
    			"col.shadow" = "rgba(1a1a1aee)";
		};
	
	        # Input
	        input = {
	          kb_layout = "us";
	          follow_mouse = 1;
	        };

	        device = {
	            name = "epic-mouse-v1";
	            sensitivity = -0.5;
	        };
	          
	        # Keybinds
	        bind = [
	          "$mod, T, exec, $terminal"
	          "$mod, Q, killactive"
	          "$mod, E, exec, $fileManager"
	          "$mod, S, togglefloating,"
	          "$mod, F, fullscreen,"
	          "$mod, R, exec, $menu"
	          "ALT, TAB, exec, $taskswitcher"
		  "$mod, M, exec, $emojiselector"
		  "$mod, B, exec, $browser"
		  "$mod SHIFT, S, exec, hyprshot -m region"
		  ",PRINT, exec, hyprshot -m output"
		  "$mod, J, togglesplit,"
		  "$mod, P, exec, $power"

	          # Switch focus
	          "$mod, left, movefocus, l"
	          "$mod, right, movefocus, r"
	          "$mod, up, movefocus, u"
	          "$mod, down, movefocus, d"
	          
		  # Move windows around
		  "$mod SHIFT, left, movewindow, l"
		  "$mod SHIFT, right, movewindow, r"
		  "$mod SHIFT, up, movewindow, u"
		  "$mod SHIFT, down, movewindow, d"
		  	  
	          # Switching workspaces
	          "$mod, 1, workspace, 1"
	          "$mod, 2, workspace, 2"
	          "$mod, 3, workspace, 3"
	          "$mod, 4, workspace, 4"
	          "$mod, 5, workspace, 5"
	          "$mod, 6, workspace, 6"
	          "$mod, 7, workspace, 7"
	          "$mod, 8, workspace, 8"
	          "$mod, 9, workspace, 9"
	          "$mod, 0, workspace, 10"
	          
	          # move active window to another workspace
	          "$mod SHIFT, 1, movetoworkspace, 1"
	          "$mod SHIFT, 2, movetoworkspace, 2"
	          "$mod SHIFT, 3, movetoworkspace, 3"
	          "$mod SHIFT, 4, movetoworkspace, 4"
	          "$mod SHIFT, 5, movetoworkspace, 5"
	          "$mod SHIFT, 6, movetoworkspace, 6"
	          "$mod SHIFT, 7, movetoworkspace, 7"
	          "$mod SHIFT, 8, movetoworkspace, 8"
	          "$mod SHIFT, 9, movetoworkspace, 9"
	          "$mod SHIFT, 0, movetoworkspace, 10"
	          
	        ];
	        
	        # Mouse keybinds
	        bindm = [
	          "$mod, mouse:272, movewindow"
	          "$mod, mouse:273, resizewindow"
	        ];
	        
	        # Windows and workspaces
	        windowrulev2 = [
	          "suppressevent maximize, class:.*"
	          "float,class:^()$,title:^(Picture in picture)$"
		  "float,class:^(firefox)$,title:^(Save File)$"
	    	  "float,class:^(firefox)$,title:^(Open File)$"
		  "float,class:^(firefox)$,title:^(Picture-in-Picture)$"
		  "float,class:^(xdg-desktop-portal-gtk)$"
		  "float,class:^(xdg-desktop-portal-kde)$"
		  "float,class:^(xdg-desktop-portal-hyprland)$"
		  "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
		  "float,class:^(zenity)$"
		  "float,class:^()$,title:^(Steam - Self Updater)$"
	        ];

	        windowrule = [
	          "float,pavucontrol"
	          "float,Rofi"
	        ];
	        
	        misc = {
	          force_default_wallpaper = 0;
		  disable_hyprland_logo = true;
		  focus_on_activate = true;
		  vfr = 1;
		  always_follow_on_dnd = true;
		  layers_hog_keyboard_focus = true;
		  animate_manual_resizes = false;
		  enable_swallow = true;
	        };

		master = {
		  no_gaps_when_only = false;
		  special_scale_factor = 0.8;
		};

		dwindle = {
		  pseudotile = false;
		  preserve_split = true;
		};
	        
	      };
	    };
}
