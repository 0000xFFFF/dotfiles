# install docker and ollama
> pacman -S docker ollama

# get docker bridge ip
> docker network inspect bridge

# edit ollama config, add the `172.17.0.1` ip to ollama config
> sudo vim /etc/systemd/system/multi-user.target.wants/ollama.service

add `Environment="OLLAMA_HOST=172.17.0.1` to file
```
[Unit]
Description=Ollama Service
Wants=network-online.target
After=network.target network-online.target

[Service]
ExecStart=/usr/bin/ollama serve
WorkingDirectory=/var/lib/ollama
Environment="HOME=/var/lib/ollama"
Environment="OLLAMA_MODELS=/var/lib/ollama"
Environment="OLLAMA_HOST=172.17.0.1
User=ollama
Group=ollama
Restart=on-failure
RestartSec=3
RestartPreventExitStatus=1
Type=simple
PrivateTmp=yes
ProtectSystem=full
ProtectHome=yes

[Install]
WantedBy=multi-user.targ
```

# start ollama
> systemctl start ollama

# start docker
> systemctl start docker.socket
> systemctl start docker.service

# run open-webui in docker
> docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend^Cata --name open-webui --restart always ghcr.io/open-webui/open-webui:main

# make admin account

## reset admin account
> docker exec -it open-webui /bin/sh
> cd data
> rm webui.db
> docker restart open-webui

