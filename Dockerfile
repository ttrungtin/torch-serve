FROM nvcr.io/nvidia/pytorch:23.05-py3

RUN apt-get -y update && \
    apt-get install ffmpeg libsm6 libxext6 default-jdk -y && \
    pip install --upgrade pip

WORKDIR /torch-serve

COPY . .

RUN pip install -r requirements.txt

