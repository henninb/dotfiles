import time
import paho.mqtt.client as paho
import requests

# pip install paho-mqtt

broker="192.168.100.124"
Connected = False

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Connected to broker")
        global Connected
        Connected = True
    else:
        print("Connection failed")

def on_message(client, userdata, message):
    time.sleep(1)
    print("received message: ", str(message.payload.decode("utf-8")))
    try:
      # code_that_raises()
      response = requests.post('http://localhost:8080/post', data ={'key':'value'})
    except Exception as e:
      print(type(e))
    # print(response)
    # print(response.json())


# client = paho.Client("python")
# client.on_message=on_message
# print("connecting to broker: ", broker)
# client.connect(broker)
# client.loop_start()
# print("subscribing to gps")
# client.subscribe("gps")
# time.sleep(10000)
# client.disconnect()
# client.loop_stop()


client = paho.Client("python")
client.on_connect= on_connect
client.on_message= on_message

client.connect(broker)

client.loop_start()
while Connected != True:
    time.sleep(0.1)

client.subscribe("gps")

try:
    while True:
        time.sleep(1)

except KeyboardInterrupt:
    print ("exiting")
    client.disconnect()
    client.loop_stop()

