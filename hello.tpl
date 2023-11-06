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
sudo dnf install -y python3-pip
pip install flask
cat > app.py <<EOF
from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "${output}"

if __name__ == "__main__":
    app.run()
EOF
flask run -h 0.0.0.0 -p 8000
