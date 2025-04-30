
local Fovy = require "libs.fovy"
local Global = require "global"
local Weapon = require "data.weapon"

Weapon:create(1, "arminha", {})

Fovy:printTable(Global.weaponData)

