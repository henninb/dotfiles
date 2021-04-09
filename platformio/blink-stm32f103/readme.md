https://www.youtube.com/watch?v=rfBeq-Fu0hc

dfu method of upload - fails to work for me as of now.


cp $HOME/.platformio/packages/framework-arduinoststm32-maple/tools/linux64/hid-flash $HOME/.platformio/packages/tool-stm32duino/


You have to enable USB CDC in USB support in the menu else you will not be able to upload again as it require USB CDC to send magic sequence
