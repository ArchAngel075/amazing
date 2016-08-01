--[[
  'Traveler' Maze Generator for LUA LOVE
  @Author : ArchAngel075 | Jaco Kotzé
  License = DO WHAT YOU WANT*
    *But please kind append original @author to any modified versions.
--]]

--[[
  Will consist of multiple types of maze types.
  
  1. Cellular automata.
  2. Rooms

  Standard generates cellular automata
--]]
local folderOfThisFile = (...):match("(.-)[^%.]+$")
local class = require (folderOfThisFile .. "amazing.30log")
local mazing = class("Archis.Amazing.Standard.Mazing")
local instance = mazing() --singleton class that helps manage all of Traveler library functions
mazing._VERSION = "0.0.0.1alpha"
mazing.standard = {}
mazing.standard.Maze = require(folderOfThisFile .. "aMazing.standard.maze")

mazing.adjacent = {
    {1,0},
    {-1,0},
    {0,1},
    {0,-1},
}

mazing.diagonal = {
    {1,1},
    {1,-1},
    {-1,1},
    {-1,-1},
}

mazing.adjacent_and_diagonal = {
    {1,1},
    {1,-1},
    {-1,1},
    {-1,-1},
    
    {1,0},
    {-1,0},
    {0,1},
    {0,-1},
}

function mazing.new() 
  error('Cannot instantiate the core Traveler class') 
end
function mazing.init() end

function mazing.extend() 
  error('Cannot extend the core Traveler class')
end

function mazing:getInstance()
  return instance
end

function mazing:getInstance()
  return instance
end

function mazing.DoesTableContain(tbl,itm)
  for k,v in pairs(tbl) do
    if (v == itm) then 
      return true 
    end
  end
  return false
end

return instance

