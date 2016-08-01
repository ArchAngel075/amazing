local folderOfThisFile = (...):match("(.-)[^%.]+$")
local fotf_reversed = string.reverse(folderOfThisFile)
local slashStart,slashEnd = string.find(fotf_reversed,"[.]",2)
local downOne = string.reverse(string.sub(fotf_reversed,slashStart+1)) .. "."

local class = require (downOne .. "30log")

local Maze= class("Archis.Amazing.Standard.Maze")
Maze.Tile = require (folderOfThisFile .. "tile")
--[[
  
--]]

Maze.Tiles = nil
Maze.size_x = nil
Maze.size_y = nil
Maze.adjacent = {
    {1,0},
    {-1,0},
    {0,1},
    {0,-1},
}

function Maze:init(size_x,size_y,chance_to_solid,cycles)
  math.randomseed(os.clock())
  --math.random()
  --math.random()
  self.size_x = size_x
  self.size_y = size_y
  local chance_to_solid = chance_to_solid or 40
  local cycles = cycles or 4
  self.Tiles = {}
  for tile_x = 0,size_x do
    self.Tiles[tile_x] = self.Tiles[tile_x] or {}
    for tile_y = 0,size_y do
      self.Tiles[tile_x][tile_y] = Maze.Tile(tile_x,tile_y)
      if math.random(0,100) < chance_to_solid or tile_x == 1 or tile_x == size_x or tile_y == 1 or tile_y == size_y then
        self.Tiles[tile_x][tile_y]:SetValue("wall")
      end
    end
  end
  
  for cycle = 1,cycles do
    self:CycleAutomata()
  end
  for k_x,v_x in ipairs(self.Tiles) do
    for k_y,v_y in ipairs(v_x) do
      local isEdge = (k_x == 1 or k_x == size_x or k_y == 1 or k_y == size_y)
      if(self:GetTile(k_x,k_y):GetValue() == "wall" and not isEdge) then self:GetTile(k_x,k_y):SetValue("empty") else self:GetTile(k_x,k_y):SetValue("wall") end
    end
  end
end

function Maze:CycleAutomata()
  for k_x,v_x in ipairs(self.Tiles) do
    for k_y,v_y in ipairs(v_x) do
      local edge = (k_x == 1 or k_x == self.size_x or k_y == 1 or k_y == self.size_y)
      local n_count_walls_1 , n_count_empty_1 = self:GetCountsWithinN(k_x,k_y)
      local n_count_walls_2 , n_count_empty_2 = self:GetCountsWithinN(k_x,k_y,2)
      if(n_count_walls_1 >= 5 or n_count_walls_2 <= 2) then
        self:GetTile(k_x,k_y):SetValue("wall")
      end
    end
  end
end

function Maze:GetCountsWithinN(x,y,n)
  local n = n or 1
  local tile = self:GetTile(x,y)
  local n_count_walls = 0
  local n_count_empty = 0
  for k,v in pairs(Maze.adjacent) do
    local neighbor = self:GetTile(tile.position_x + v[1]*n,tile.position_y + v[2]*n)
    if(neighbor) then
      if(neighbor:GetValue() == "wall") then
        n_count_walls = n_count_walls + 1
      else
        n_count_empty = n_count_empty + 1
      end
    end
  end
  return n_count_walls , n_count_empty
end

function Maze:GetTile(x,y)
  if(x < 1 or y < 1 or x > self.size_x or y > self.size_y or (not self.Tiles[x] and not self.Tiles[x][y])) then
    return false
  else
    return self.Tiles[x][y]
  end
end

function Maze:DebugDraw(offset_x,offset_y,scale_x,scale_y)
  love.graphics.push()
  love.graphics.scale(scale_x or 1,scale_y or 1)
  love.graphics.translate(offset_x or 0,offset_y or 0)
  local r = 32
  local s = 8
  love.graphics.setColor(255,255,255,255)
  for k_x,v_x in ipairs(self.Tiles) do
    for k_y,v_y in ipairs(v_x) do
      local drawMode = "line"
      if(v_y:GetValue() == "wall") then drawMode = "fill" end
      love.graphics.circle(drawMode,k_x*(r) - r/2 , k_y*(r) - r/2 , r/2 , s)
    end
  end
  
  love.graphics.pop()
end

return Maze