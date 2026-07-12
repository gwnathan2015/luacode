-- story game about magical creatures and quests

local function sign(value)
    if value > 0 then return 1 end
    if value < 0 then return -1 end
    return 0
end

sprites = {}

require ("map")
local characters = require ("characters")
require("mapreader")

game_map1 = read_map("map1.json")

characters.main_character = characters.Character:new("player", 1085, game_map1)
characters.main_character:move(2,1)

characters.wizard = characters.Character:new("wizard", 1084, game_map1)
characters.wizard:move(10,2)

characters.swordsman = characters.Character:new("Swordsman", 1097, game_map1)
characters.swordsman:move(7,4)

function swordsman_choose_destination()
    return characters.main_character:pos()
end

function move_swordsman()
    local swordsman_destination_pos = swordsman_choose_destination()
    local swordsman_current_pos = characters.swordsman:pos()

    -- destination is x = 5, y = 3
    -- current is     x = 2, y = 9

    local difference_in_x = swordsman_destination_pos.x - swordsman_current_pos.x
    local step_in_x = sign(difference_in_x)

    local difference_in_y = swordsman_destination_pos.y - swordsman_current_pos.y
    local step_in_y = sign(difference_in_y)

    -- Only allows -1, 0, 1
    characters.swordsman:move(step_in_x, step_in_y)
end

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

    love.window.setTitle("Storygame PA-1.8")
end

time_total = 0
function love.update(step_in_time)
   time_total = time_total + step_in_time
   if time_total >= 1 then
      time_total = time_total - 1
      move_swordsman()
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
    if key == "escape" then
        love.event.quit()
    elseif key == "w" then
        characters.main_character:move(0, -1)
    elseif key == "a" then
        characters.main_character:move(-1, 0)
    elseif key == "s" then
        characters.main_character:move(0, 1)
    elseif key == "d" then
        characters.main_character:move(1, 0)
    end
end

