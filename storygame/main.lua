-- story game about magical creatures and quests

sprites = {}

require ("map")
local characters = require ("characters")
require("mapreader")

game_map1 = read_map("map1.json")

function love.load()
    love.keyboard.setKeyRepeat( true )
    for i = 0, 131 do
        local filename = string.format("ASSETS/tinytown/Tiles/tile_%04d.png", i)
        sprites[i] = love.graphics.newImage(filename)
    end
    for i = 0, 131 do
        local filename = string.format("ASSETS/tinydungeon/Tiles/tile_%04d.png", i)
        sprites[i + 1000] = love.graphics.newImage(filename)
    end
end

function love.draw()
    local col_number, row_number, row, x_c, y_c
    draw_map(game_map1, sprites)
    characters.draw_characters(sprites)
    draw_map_overlay(game_map1, sprites)
end

--- 85 new main character for now


function love.keypressed(key, scancode, isrepeat)
    local future_dx = 0
    local future_dy = 0

    if key == "escape" then
        love.event.quit()
    elseif key == "w" then
        future_dy =  -1
    elseif key == "a" then
        future_dx = -1
    elseif key == "s" then
        future_dy = 1
    elseif key == "d" then
        future_dx = 1
    end
    if characters.is_move_allowed(
        characters.main_character.x + future_dx, 
        characters.main_character.y + future_dy, 
        game_map1) then
        characters.main_character:move(future_dx, future_dy)
    end
end

