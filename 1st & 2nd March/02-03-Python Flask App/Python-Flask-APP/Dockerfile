FROM python:3.13.2

WORKDIR /app

COPY dependencies.txt .

RUN pip install -r dependencies.txt

COPY .  .

EXPOSE 5000

CMD [ "python" , "app.py" ]