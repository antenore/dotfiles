task :default => [:init, :stow]

DOTFILES_DIR = ".dotfiles"
PACKAGES = %w(
    X
    colors
    conky
    init
    scripts
    spectrwm
    top
    urxvt
    vim
    zsh
)
PREFIX = Dir.home
BIN = File.join(PREFIX, "bin")

task :init do

    if Dir.exist? BIN
        warn "~/bin already exists"
    else
        Dir.mkdir(BIN, 0700)
    end
end

task :stow do
    puts "stow test"
end

