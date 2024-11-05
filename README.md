
  

# Hướng dẫn Setup Server 

  

EMQX server đang sử dụng bản miễn phí, nên mỗi lần build lại container, bạn cần xóa user admin mặc định. Nếu quên là khum chịu trách nhiệm nha :>

  

## Bước 1: Cài đặt Docker và Docker Compose

  

### 1. Cập nhật Hệ thống

```bash

sudo  apt-get  update

sudo  apt-get  upgrade

```

  

### 2. Cấu hình Docker

```bash

sudo  apt-get  install  \

apt-transport-https \

ca-certificates  \

curl \

gnupg  \

lsb-release

```

  

### 3. Cài Docker

```bash

curl  -fsSL  https://download.docker.com/linux/ubuntu/gpg | sudo  gpg  --dearmor  -o  /usr/share/keyrings/docker-archive-keyring.gpg

echo  "deb [arch=$(dpkg  --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release  -cs) stable" | sudo  tee  /etc/apt/sources.list.d/docker.list > /dev/null

sudo  apt  update

sudo  apt-get  install  docker-ce  docker-ce-cli  containerd.io

```

  

### 4. Cài Docker Compose

```bash

sudo  curl  -L  "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname  -s)-$(uname  -m)"  -o  /usr/local/bin/docker-compose

sudo  chmod  +x  /usr/local/bin/docker-compose

```

  

## Bước 2: Tải và Cấu hình Dự án

  

### 1. Clone Repository

```bash

git  clone  --recurse-submodules  https://github.com/pcthuoc/docker_mqtt.git

cd  docker_mqtt

```

  

### 2. Cấu hình Environment

- Trong thư mục `environment`, cập nhật `user` và `password` của database theo nhu cầu.

- Cập nhật các biến môi trường cho server MQTT:

```plaintext

MQTT_BROKER_HOST=206.189.94.251

MQTT_BROKER_PORT=1883

MQTT_TOPIC=API/#

MQTT_USERNAME=pcthuoch

MQTT_PASSWORD=thuocadmin

```

  

## Bước 3: Build và Khởi động Containers

  

### 1. Build Image

```bash

docker  compose  build

```

  

### 2. Khởi động Web

```bash

sudo  docker  compose  up  -d  site

```

  

### 3. Tạo Cơ sở Dữ liệu

```bash

sudo  ./scripts/migrate

```

  

### 4. Khởi động Hệ thống

```bash

sudo  docker-compose  up  -d

```

  

---

  

## Bước 4: Thiết Lập Cấu Hình MQTT

  

1.  **Xóa tài khoản mặc định `admin`:**

```bash

./scripts/mqtt_delete_user admin

```

2.  **Tạo tài khoản mới:**

```bash

./scripts/mqtt_create_user <user> <pass>

```

  

3.  **Cập nhật API xác thực**: Chọn Password-Based và HTTP Server

<img  src="https://goldedu.vn/martor/104ab7f5-1b34-4126-9c7e-7b600a6b8a07.png"  alt="Authentication Setup"  width="400"/>

  

- Thay thế giá trị địa chỉ server và thêm vào body như mô tả

<img  src="https://goldedu.vn/martor/4664741f-40c5-44d3-95c7-96b262dc8ddf.png"  alt="Body Setup"  width="400"/>

  

4.  **Thiết lập Authorization**

<img  src="https://goldedu.vn/martor/1df6c1ce-ed5b-4d99-81d4-776b9522d268.png"  alt="Authorization Setup"  width="400"/>

  

5.  **Đăng ký API để cập nhật trạng thái kết nối hệ thống**

<img  src="https://goldedu.vn/martor/78e8b6e9-b528-4d56-9128-abcb661cc0be.png"  alt="API Registration"  width="400"/>

  

---
6  **Kết quả**

<img  src="https://goldedu.vn/martor/e5fc37e6-4a25-4ca0-86b2-6da23de86338.png"  alt="API Registration"  width="400"/><img  src="https://goldedu.vn/martor/f383c5f1-89f3-46eb-8065-3d43bfa6e61b.png"  alt="API Registration"  width="400"/>

<img  src="https://goldedu.vn/martor/78104eba-38f9-42b0-85a7-ac827814b93f.png"  alt="API Registration"  width="400"/><img  src="https://goldedu.vn/martor/67e21118-3a8f-41c0-8c2a-aa1b35c1b741.png"  alt="API Registration"  width="400"/>

<img  src="https://goldedu.vn/martor/864b7923-4d68-4c6c-b963-b160e00fed8b.png"  alt="API Registration"  width="400"/><img  src="https://goldedu.vn/martor/25b1c33f-8138-463f-8999-c1f4ee3e6c33.png"  alt="API Registration"  width="400"/>



  
