local folderOfThisFile = (...):match("(.-)[^%.]+$")
local fotf_reversed = string.reverse(folderOfThisFile)
local slashStart,slashEnd = string.find(fotf_reversed,"[.]",2)
local downOne = string.reverse(string.sub(fotf_reversed,slashStart+1)) .. "."
local class = require (downOne .. "30log")

local Tile = class("Archis.Amazing.Standard.Tile")

--[[
  
--]]

Tile.position_x = nil
Tile.position_y = nil
Tile.value = nil

function Tile:init(position_x,position_y,value)
  local value = value or "empty"
  self.position_x = position_x
  self.position_y = position_y
end

function Tile:SetValue(value)
  self.value = value or "empty"
end

function Tile:GetValue(value)
  return self.value
end

return Tile