docker run -d \
  --name frigate \
  --restart unless-stopped \
  --shm-size=512mb \
  -p 5000:5000 \
  -p 1935:1935 \
  -v "$(pwd)/config/config.yml:/config/config.yml:ro" \
  -v "$(pwd)/clips:/clips" \
  -v "$(pwd)/recordings:/recordings" \
  -v "$(pwd)/cache:/cache" \
  ghcr.io/blakeblackshear/frigate:stable


docker run -d \
  --name mosquitto \
  --restart unless-stopped \
  -p 1883:1883 \
  eclipse-mosquitto:2



docker run -d \
  --name frigate \
  --restart unless-stopped \
  --platform linux/arm64 \
  --shm-size=512mb \
  -p 5000:5000 \
  -p 1935:1935 \
  -v "$(pwd)/config/config.yml:/config/config.yml:ro" \
  -v "$(pwd)/clips:/clips" \
  -v "$(pwd)/recordings:/recordings" \
  -v "$(pwd)/cache:/cache" \
  ghcr.io/blakeblackshear/frigate:stable-standard-arm64
