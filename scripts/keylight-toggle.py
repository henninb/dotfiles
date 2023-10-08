import leglight

allLights = leglight.discover(2)

print(allLights)

myLight = leglight.LegLight('192.168.20.60',9123)

vars(myLight)
myLight.on()
# mylight.off()
