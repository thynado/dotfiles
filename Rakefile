require 'ostruct'

$home = OpenStruct.new({
    :path => ENV["HOME"],
    :config => ENV["HOME"] + '/.config',
    :library => ENV["HOME"] + '/Library/Application\\ Support',
})

$repo = OpenStruct.new({
    :path => Dir.pwd,
    :config => "#{Dir.pwd}/config"
})

class String
    def method_missing(name, *args)
        colors = [:white, :black, :red, :green, :yellow, :blue, :magenta, :cyan]
        "\e[#{colors.index(name) + 29}m#{self}\e[0m"
    end

    def info
        puts "#{"ℹ".blue} #{self}"
    end
end

desc 'Install configuration files'
task :install do
    "Installing config...".info

    system "rsync -av #{$repo.config}/git/* #{$home.path}/.config/git -q"
    system "rsync -av #{$repo.config}/zsh/.zshrc #{$home.path}/.zshrc -q"
    system "rsync -av #{$repo.config}/hyper/.hyper.js #{$home.path}/.hyper.js -q"
    system "rsync -av #{$repo.config}/hyper/.hyper.css #{$home.path}/.hyper.css -q"
    system "rsync -av #{$repo.config}/neofetch/* #{$home.path}/.config/neofetch -q"
    system "rsync -av #{$repo.config}/hammerspoon/init.lua #{$home.path}/.hammerspoon/init.lua -q"
    system "rsync -av #{$repo.config}/vscode/* #{$home.library}/Code/User -q"
    system "rsync -av #{$repo.config}/sublime-text/* #{$home.library}/Sublime\\ Text\\ 3/Packages/User/ -q"
end

desc 'Backup configuration files'
task :backup do
    "Backing up config...".info

    system "rsync --ignore-missing-args #{$home.path}/.config/git/ #{$repo.config}/git -q"
    system "rsync --ignore-missing-args #{$home.path}/.zshrc #{$repo.config}/zsh/.zshrc -q"
    system "rsync --ignore-missing-args #{$home.path}/.hyper.js #{$repo.config}/hyper/.hyper.js -q"
    system "rsync --ignore-missing-args #{$home.path}/.hyper.css #{$repo.config}/hyper/.hyper.css -q"
    system "rsync --ignore-missing-args #{$home.path}/.config/neofetch/ #{$repo.config}/neofetch -q"
    system "rsync --ignore-missing-args #{$home.path}/.hammerspoon/init.lua #{$repo.config}/hammerspoon/init.lua -q"
    system "rsync --ignore-missing-args #{$home.library}/Code/User/ #{$repo.config}/vscode -q"
    system "rsync --ignore-missing-args #{$home.library}/Sublime\\ Text\\ 3/Packages/User/ #{$repo.config}/sublime-text -q"
end

task :default do
    `rake -T`.split("\n").map do |line|
        puts "#{"ℹ".blue} #{line.gsub(' #', '-')}"
    end
end
