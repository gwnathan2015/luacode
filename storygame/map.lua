require("mapreader")

BUSH = 5
GREEN = 1
FLOWERS = 2
PATH = 25
TREE_L = 15
TREE_U = 3

game_map1 = read_map("map1.json")
    game_map2 = {
        { { u = { GREEN }, o = { TREE_U } }, { u = { GREEN } },   { u = { FLOWERS } }, { u = { GREEN } },   { u = { FLOWERS } }, { u = { FLOWERS } }, { u = { FLOWERS } }, { u = { GREEN } },   { u = { GREEN } } },
        { { u = { GREEN, TREE_L } },         { u = { PATH } },    { u = { PATH } },    { u = { FLOWERS } }, { u = { GREEN } },   { u = { GREEN } },   { u = { PATH } },    { u = { FLOWERS } }, { u = { FLOWERS } } },
        { { u = { FLOWERS } },               { u = { PATH } },    { u = { GREEN } },   { u = { GREEN } },   { u = { FLOWERS } }, { u = { FLOWERS } }, { u = { GREEN } },   { u = { PATH } },    { u = { GREEN } } },
        { { u = { GREEN } },                 { u = { FLOWERS } }, { u = { GREEN } },   { u = { PATH } },    { u = { FLOWERS } }, { u = { GREEN } },   { u = { GREEN } },   { u = { PATH } },    { u = { GREEN } } },
        { { u = { FLOWERS } },               { u = { GREEN } },   { u = { PATH } },    { u = { PATH } },    { u = { PATH } },    { u = { GREEN } },   { u = { FLOWERS } }, { u = { PATH } },    { u = { GREEN } , o = {TREE_U}} },
        { { u = { PATH } },                  { u = { FLOWERS } }, { u = { GREEN } },   { u = { PATH } },    { u = { PATH } },    { u = { FLOWERS } }, { u = { PATH } },    { u = { GREEN } },   { u = { GREEN, TREE_L } } },
        { { u = { PATH } },                  { u = { PATH } },    { u = { GREEN } },   { u = { FLOWERS } }, { u = { PATH } },    { u = { PATH } },    { u = { PATH } },    { u = { PATH } },    { u = { GREEN } } },
        { { u = { PATH } },                  { u = { GREEN } },   { u = { PATH } },    { u = { PATH } },    { u = { FLOWERS } }, { u = { PATH } },    { u = { PATH } },    { u = { GREEN } },   { u = { PATH } } },
        { { u = { PATH } },                  { u = { GREEN } },   { u = { GREEN } },   { u = { FLOWERS } }, { u = { PATH } },    { u = { GREEN } },   { u = { FLOWERS } }, { u = { GREEN } },   { u = { FLOWERS } } },
        { { u = { PATH }, o = {TREE_U} },    { u = { GREEN } },   { u = { GREEN } },   { u = { FLOWERS } }, { u = { PATH } },    { u = { GREEN } },   { u = { FLOWERS } }, { u = { GREEN } },   { u = { FLOWERS } } },
        { { u = { GREEN, TREE_L } },         { u = { GREEN } },   { u = { FLOWERS } }, { u = { FLOWERS } }, { u = { PATH } },    { u = { GREEN } },   { u = { FLOWERS } }, { u = { PATH } },   { u = { FLOWERS } } }
    }

function draw_map(game_map, sprites)
    local col_number, row_number, row, x, y
    for row_number, row in pairs(game_map) do
        for col_number, tile_info in pairs(row) do
            x = (col_number - 1) * 16
            y = (row_number - 1) * 16
            -- u: underlay of sprites
            -- o: overlay of sprites
            for depth, sprite_num in pairs(tile_info.u) do
                love.graphics.draw(sprites[sprite_num], x, y)
            end
        end
    end
end

function draw_map_overlay(game_map, sprites)
    for row_number, row in pairs(game_map) do
        for col_number, tile_info in pairs(row) do
            x = (col_number - 1) * 16
            y = (row_number - 1) * 16
            if tile_info.o ~= nil then
                for depth, sprite_num in pairs(tile_info.o) do
                    love.graphics.draw(sprites[sprite_num], x, y)
                end
            end
            --print(row_number, col_number, sprite_num)
        end
    end
end