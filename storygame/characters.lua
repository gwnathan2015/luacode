
local characters = {}

-- Any kind of character in the story game, e.g. the main player
characters.Character = {
        x = 0,
        y = 0,
        all_characters = {}
    }

characters.Character.__index = characters.Character

-- Create a new Character.
--
-- put name and sprite into the new character.
-- Add the new character to the table list of all_characters.
function characters.Character:new(name, sprite, game_map)
    local new_object = {sprite = sprite, name = name, game_map = game_map}
    setmetatable(new_object, self)
    new_object.__index = characters.Character
    table.insert(characters.Character.all_characters, new_object)
    return new_object
end


-- Moves the character around if possible, returns False if not. 
--if yes then it moves when the player presses to move, if not, then it doesnt move there when the player presses to move
-- Edits character self.x and self.y.
--
-- @param step_in_x -- Movement in x direction, relative to current position,
-- @param step_in_y -- Movement in y direction, relative to current position,
-- @return True if the move was allowed and completed.
function characters.Character:move(step_in_x, step_in_y)

    local future_x = self.x + step_in_x
    local future_y = self.y + step_in_y

    if future_x <= 0 then return false end
    if future_y <= 0 then return false end
    if future_y > #(self.game_map) then return false end
    if future_x > #(self.game_map[1]) then return false end

    for num, character in pairs(characters.Character.all_characters) do
        if future_x == character.x and future_y == character.y then
            return false 
        end
    end
    

    local future_cell = self.game_map[future_y][future_x]
    for index, sprite_num in pairs(future_cell.u) do
        if sprite_num == TREE_L then return false end
    end
    self.x = future_x
    self.y = future_y
    return true
end

-- Prints the character's information in the console.
function characters.Character:print()
    print("---- ", self.name)
    print("x=", self.x)
    print("y=", self.y)
    print("s=", self.sprite)
end

-- Makes the character appear on a Love2d canvas.
function characters.Character:draw(sprites)
        local x_c = (self.x - 1) * 16
        local y_c = (self.y - 1) * 16
        local c_sprite = self.sprite
        -- Draw character sprites
        love.graphics.draw(sprites[c_sprite], x_c, y_c)
end

function characters.draw_characters(sprites)
    for num, character in pairs(characters.Character.all_characters) do
        character:draw(sprites)
    end
end


return characters