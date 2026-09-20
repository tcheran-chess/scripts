#!/usr/bin/env bash

export OPENBENCH_PASSWORD="$1"

apt update
apt install -y git python3-venv tmux build-essential
export RUSTUP_HOME=/opt/rust
export CARGO_HOME=/opt/rust
curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
adduser openbench --system
git clone https://github.com/tcheran-chess/openbench /opt/openbench
chown -R openbench /opt/rust
chown -R openbench /opt/openbench
# mkdir -p /opt/syzygy
# chown -R openbench /opt/syzygy
# pushd /opt/syzygy && wget --mirror --no-parent --no-directories -e robots=off https://tablebase.lichess.ovh/tables/standard/3-4-5-wdl/ && popd
cd /opt/openbench/Client
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
export OPENBENCH_USERNAME=jgilchristworkers
export OPENBENCH_SERVER=https://openbench.jgilchrist.uk
export CARGO_HOME=/opt/rust
export RUSTUP_HOME=/opt/rust
PATH=/opt/rust/bin:$PATH /opt/openbench/Client/.venv/bin/python -u client.py -T auto -N 1 -I $(hostname) --syzygy /opt/syzygy
