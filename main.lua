-- @Author: bbales
-- @Date:   2015-05-02 20:07:31
-- @Last Modified by:   bbales
-- @Last Modified time: 2015-05-03 11:43:50

-- Read network configuration
file.open("config.txt", "r")

-- Get SSID
str = file.readline()
SSID = string.sub(str,string.find(str, ":")+1,-1)
str = nil

-- Get Password
str = file.readline()
PWD = string.sub(str,string.find(str, ":")+1,-1)    
str = nil

file.close()

-- Set up network config
cfg = {ip="192.168.4.1",netmask="255.255.255.0",gateway="192.168.4.1"}
wifi.ap.setip(cfg)

-- Create access point
wifi.setmode(wifi.SOFTAP)
wifi.sta.config(SSID,PWD)

-- Free variables
SSID = nil
PWD = nil

-- Close existing servers
if srv then
  srv:close()
end

-- Create TCP server
srv = net.createServer(net.TCP,1)

-- Listen on port 80
srv:listen(80, function(conn)

    -- Handle requests
    conn:on("receive", function(conn, payload)
        local req = string.sub(payload, string.find(payload,'GET /')+5,string.find(payload,'HTTP')-2)

        -- Multiplex requests
        switchBox(req)

        -- 

        -- returning data takes a significant amount of time.
        -- conn:send('data')
        
        -- Clean up
        req = nil
        conn:close()
    end)
end)
