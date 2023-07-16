import leglight

allLights = leglight.discover(2)

print(allLights)

myLight = leglight.LegLight('192.168.10.36',9123)

myLight.on()
# mylight.off()
