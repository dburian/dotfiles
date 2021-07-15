#!/home/dburian/.local/bin/awesome-lua

local naughty = require('naughty')

naughty.notify({
    title = 'Test notification',
    text = 'Hola!'
})
