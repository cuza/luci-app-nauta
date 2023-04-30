-- Create a new map
m = Map("etecsa", "ETECSA")

-- Add a section to the mapx
s = m:section(NamedSection, "nauta", "Auto Login", "Nauta Plus Account Details.")

-- Add a field for the user
s:option(Value, "username", "Username", "Enter the username")

-- Add a field for the password
password = s:option(Value, "password", "Password", "Enter the password.")
password.password = true

-- Add a field for the enabled checkbox
s:option(Flag, "autologin", "Auto Login", "Automaticaly login to ETECSA Nauta.")

return m
