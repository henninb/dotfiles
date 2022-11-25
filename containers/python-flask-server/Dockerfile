FROM python:3.8-slim-buster

#WORKDIR /home/henninb
#USER henninb

WORKDIR /python-docker

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY app.py .

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
