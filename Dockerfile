FROM ubuntu:20.04

# タイムゾーンの設定を対話的にさせない
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

# パッケージリストの更新とインストール
RUN apt-get update && apt-get install -y \
    binutils \
    build-essential \
    golang \
    sysstat \
    python3-matplotlib \
    python3-pil \
    fonts-takao \
    fio \
    qemu-kvm \
    virt-manager \
    libvirt-clients \
    virtinst \
    jq \
    docker.io \
    containerd \
    libvirt-daemon-system \
    strace \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 一般ユーザーの作成とグループ追加
RUN useradd -m -s /bin/bash developer && \
    usermod -aG libvirt developer && \
    usermod -aG libvirt-qemu developer && \
    usermod -aG kvm developer

# 作成したユーザーに切り替え
USER developer

WORKDIR /workspace

CMD ["/bin/bash"]