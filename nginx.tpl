Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
cloud_final_modules:
- [scripts-user, always]

--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"

#!/bin/bash
sudo dnf install -y nginx
sudo tee /etc/nginx/nginx.conf <<EOF
events {
}

http {
    map \$http_x_api_key \$proxy_pass {
        default "";
        "key0" "http://${hello0_ip}:8000";
        "key1" "http://${hello1_ip}:8000";
    }

    server {
        listen 80;

        location / {
            if (\$proxy_pass = "") {
                return 401;  # unauthenticated
            }
            proxy_pass \$proxy_pass;
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
        }
    }
}
EOF
sudo systemctl start nginx
