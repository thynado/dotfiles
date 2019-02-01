require 'ostruct'

$home = OpenStruct.new({
    :path => ENV["HOME"],
    :config => ENV["HOME"] + '/.config',
    :library => ENV["HOME"] + '/Library/Application Support',
})

$repo = OpenStruct.new({
    :path => Dir.pwd,
    :config => "#{Dir.pwd}/config"
})

$config = [
    ['git/*', '/.config/git'],
    ['zsh/.zshrc', '/.zshrc'],
    ['hyper/.hyper.js', '/.hyper.js'],
    ['hyper/.hyper.css', '/.hyper.css'],
    ['neofetch/*', '/.config/neofetch'],
    ['valet/Drivers/*', '/.config/valet/Drivers'],
    ['hammerspoon/init.lua', '/.hammerspoon/init.lua'],
    ['vscode/*', '/Library/Application Support/Code/User'],
    ['sublime-text/*', '/Library/Application Support/Sublime Text 3/Packages/User/'],
];

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

    $config.each do |paths|
        from, to = paths
        to.gsub! ' ', '\\ '

        puts "rsync -av #{$repo.config}/#{from} #{$home.path}#{to} -q"
    end
end

desc 'Backup configuration files'
task :backup do
    "Backing up config...".info

    $config.each do |paths|
        from, to = paths
        to.gsub! ' ', '\\ '

        puts "rsync -av #{$home.path}#{to} #{$repo.config}/#{from} -q"
    end
end

task :default do
    `rake -T`.split("\n").map do |line|
        puts "#{"ℹ".blue} #{line.gsub(' #', '-')}"
    end
end
