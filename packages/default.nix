{ config, lib, pkgs, pkgs-unstable, ... }:

{
  imports = [ 
    ./proxychains.nix
  ];
  
  # List the packages you want to be installed system-wide.
  environment.systemPackages = with pkgs; [

    # === DEVELOPMENT TOOLS === #
    git                         # Version control
    micro                       # Modern  terminal text editor
    vim                         # Classic terminal text editor
    go                          # Go programming language
    gopls                       # Go language server
    nixfmt-rfc-style            # Nix code formatter
    vscodium-fhs                # VS Code alternative (FHS compatibility)
    temurin-bin                 # Java distribution by Adoptium

    # === SYSTEM UTILITIES & MANAGEMENT === #
    wget                        # Download manager
    bat                         # `cat`/`less` with syntax highlighting
    fd                          # Modern `find` replacement
    eza                         # Modern `ls` replacement
    zoxide                      # Smarter `cd` command
    tree                        # Directory tree viewer
    gdu                         # Disk usage analyzer (ncdu on steroids)
    zip                         # Compressor/archiver for zipfiles
    rar                         # Utility for RAR archives
    unar                        # Archive unpacker program
    unrar-wrapper               # Backwards compatibility between unar and unrar
    unzip                       # Extraction utility for zipfiles
    p7zip                       # New p7zip fork
    gparted                     # Disk partitioning tool
    czkawka-full                # Deduplication toolbox
    ryzenadj                    # AMD CPU tuning utility
    lact                        # AMD GPU tuning utility
    qtscrcpy                    # Android screen mirroring (Qt)
    scrcpy                      # Android screen mirroring
    rclone                      # Ultimate cloning utility
    ghostty                     # GPU-accelerated terminal
    krusader                    # Ultimate File Manager
    kdePackages.kompare         # Graphical file differences tool
    krename                     # Powerful batch renamer for KDE

    # === INFO & MONITORING === #
    btop                        # System monitor (TUI)
    resources                   # System monitor (GUI)
    mission-center              # System monitor (GUI) 
    fastfetch                   # System information tool (CLI)
    pfetch-rs                   # System information tool (CLI, minimal)
    inxi                        # System information tool (CLI, advanced)
    cpu-x                       # System information tool (GUI)

    # === MULTIMEDIA & GRAPHICS === #
    vlc                         # Media player
    mpv                         # Media player
    mkvtoolnix                  # MKV manipulation tool
    ffmpeg_6-full               # Multimedia framework
    flowblade                   # Video editor
    krita                       # Digital painting
    inkscape-with-extensions    # Vector graphics editor
    pinta                       # MS Paint alternative
    gpu-screen-recorder         # Screen recording tool
    libjxl                      # JPEG XL image format

    # === INTERNET === #
    librewolf                   # Privacy-focused Firefox fork
    ungoogled-chromium          # Chromium without Google integration

    # === COMMUNICATION === #
    fractal                     # Matrix client
    ayugram-desktop             # Telegram client on steroids
    materialgram                # Telegram client
    vesktop                     # Discord client
    revolt-desktop              # Discord alternative
    briar-desktop               # Secure messaging

    # === FILE SHARING & DOWNLOAD === #
    localsend                   # Local file sharing
    syncthing                   # Local file sync
    syncthingtray               # Local file sync integration
    qbittorrent-enhanced        # Torrent client

    # === OFFICE & PRODUCTIVITY === #
    onlyoffice-desktopeditors   # Better office suite
    thunderbird-latest-unwrapped# Full-featured e-mail client
    apostrophe                  # Comfy markdown editor
    keepassxc                   # Password manager
    keypunch                    # Typing practice application
    anki                        # Flashcard app

    # === ENTERTAINMENT === #
    komikku                     # Manga reader
    foliate                     # E-book reader
    gnome-podcasts              # GNOME podcast app
    youtube-music               # YouTube Music client
    shortwave                   # Internet radio player
    cozy                        # Audiobook player

    # === AI TOOLS === #
    alpaca                      # (local) AI assistant
    upscayl                     # local AI image upscaler

    # === KDE === #
    kdePackages.yakuake         # Dropdown terminal
    kdePackages.kate            # Text editor
    kdePackages.kweather        # Weather app
    kdePackages.kasts           # KDE podcast app

    # === GAMES === #
    xonotic                     # Fast-paced FPS
    veloren                     # Voxel adventure game

    # === MISC === #
    gnome-weather               # Weather app
    nerd-fonts.jetbrains-mono   # Programming fonts

  ] ++ (with pkgs-unstable; [
    # === SYSTEM UTILITIES & MANAGEMENT (UNSTABLE) === #
    superfile                   # Modern TUI file manager
    
  ]);
}
