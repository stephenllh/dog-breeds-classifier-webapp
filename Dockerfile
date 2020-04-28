FROM python:3.6-slim-stretch

RUN apt update && \
    apt install -y python3-dev gcc

WORKDIR app 
# Install pytorch and fastai
RUN pip install https://download.pytorch.org/whl/cpu/torch-1.4.0%2Bcpu-cp36-cp36m-linux_x86_64.whl

ADD requirements.txt .
RUN pip install -r requirements.txt
#pip install --no-cache-dir -r
ADD models models
ADD src src

# Run it once to trigger resnet download
RUN python src/app.py prepare

#EXPOSE 5000

# Start the server
CMD ["python", "src/app.py", "serve"]
