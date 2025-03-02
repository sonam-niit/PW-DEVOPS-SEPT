FROM python:3.9

WORKDIR /app

COPY dependencies.txt .

RUN pip install -r dependencies.txt

COPY .  .

CMD [ "python" , "app.py" ]