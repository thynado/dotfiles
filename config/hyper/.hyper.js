// -- hyper-stylesheet-hash:509560344d31fed29bd0b611afbded02 --
// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
    config: {
        updateChannel: 'canary',
        fontSize: 14,
        fontFamily: '"Fira Code", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
        uiFontFamily: '"Inter UI"',
        fontWeight: 'normal',
        fontWeightBold: 'bold',
        lineHeight: 1.6,
        letterSpacing: 0,
        cursorShape: 'BEAM',
        cursorBlink: false,
        showHamburgerMenu: '',
        shellArgs: ['--login'],
        env: {},
        bell: 'SOUND',
        copyOnSelect: false,
        defaultSSHApp: true,
        css: ``,
        termCSS: ``,
        shell: '/usr/local/bin/zsh',
        padding: '20px 15px 20px 30px',
        cursorColor: 'rgba(248, 28, 229, 0.7)',
        cursorAccentColor: '#000',
        foregroundColor: '#dadada',
        backgroundColor: '#131313',
        selectionColor: 'rgba(230, 230, 0, 0.3)',
        borderColor: 'rgba(0, 0, 0, 0)',
        summon: {
            hideDock: false,
            hideOnBlur: false,
            hotkey: 'Super+e'
        },
        colors: {
            black: '#1c1c1c',
            red: '#F44336',
            green: '#4DAF7C',
            yellow: '#FFEB3B',
            blue: '#2196F3',
            magenta: '#BA68C8',
            cyan: '#00BCD4',
            white: '#ECEFF1',
            lightBlack: '#686868',
            lightRed: '#E57373',
            lightGreen: '#8BC34A',
            lightYellow: '#FFF176',
            lightBlue: '#03A9F4',
            lightMagenta: '#BA68C8',
            lightCyan: '#4DD0E1',
            lightWhite: '#E0E0E0',
        },
    },

    plugins: ["hyperterm-summon", "hyper-hide-scroll", "hyper-stylesheet"],
    localPlugins: [], // `~/.hyper_plugins/local/`
    keymaps: {},
};
