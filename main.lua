-- @Author: bbales
-- @Date:   2015-05-02 20:07:31
-- @Last Modified by:   bbales
-- @Last Modified time: 2015-05-03 17:54:54

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
        local isOpen = false

        -- Sent listener, for chunking data
        conn:on("sent", function(conn)
            if not isOpen then
            isOpen = true
            file.open('index.html', 'r')
            end
            local data = file.read(1024) -- 1024 max
            if data then
                conn:send(data)
            else
                file.close()
                conn:close()
                conn = nil
            end
        end)

        if req == "app" then
            conn:send("HTTP/1.1 200 OK\r\n")
            conn:send("Content-type: text/html\r\n")
            conn:send("Connection: close\r\n\r\n")
        elseif req == "check" then
            conn:send("HTTP/1.1 200 OK\r\n")
            conn:send("Content-type: text/html\r\n")
            conn:send("Connection: close\r\n\r\n")    
            conn:send("1")
            conn:close()
        else
            -- Multiplex requests
            switchBox(req)

            -- Clean up
            req = nil
            conn:close()
        end
    end)
end)
