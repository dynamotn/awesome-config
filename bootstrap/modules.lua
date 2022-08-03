-- Lua modules
package.path = package.path .. ';' .. local_rc_path .. 'vendor/?.lua;' .. local_rc_path .. 'vendor/?/init.lua;'

-- C modules
package.cpath = package.cpath .. ';' .. local_rc_path .. 'vendor/?.so;'
