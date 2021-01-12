#sample user:
#username: admin
#password: default


import sqlite3
import hashlib
import uuid
import requests
from bottle import route, run, request, template, response, redirect, static_file

@route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='./views')

@route ('/', method='GET')
def index():
    return template('index')

@route('/login', method='GET')
def cookie():
    #verify cookie and redirect to default if needed
    if not request.get_cookie('COOKIE'):
        redirect('/')

@route('/login', method='POST')
def login():
    #get user info and hash password
    username = request.forms.get('username')
    password = request.forms.get('password')
    pw = password.encode('utf-8')
    pw_hash = hashlib.sha1(pw).hexdigest()

    #validate user and create cookie
    if validate_user(username, pw_hash):
        cookie_val = str(uuid.uuid4())
        response.set_cookie('COOKIE', cookie_val)
        return template('weather') 
    else:
        logError = 'Login Failed. Please try again.'
        warning = {'logError': logError}
        return template('index', warning)

@route('/newuser', method='GET')
def newuser():
    return template('newuser')

@route('/createuser', method='POST')
def createuser():
    #get new user info
    username = request.forms.get('newuser')
    password = request.forms.get('newpass')
    password2 = request.forms.get('newpass2')

    #verify passwords match and add user to database
    if password == password2:
        conn = sqlite3.connect('userdata.sqlite')
        cur = conn.cursor()
        password = password.encode('utf-8')
        pw_hash = hashlib.sha1(password).hexdigest()
        sql = "INSERT INTO users (username, password) VALUES (?, ?)"
        cur.execute(sql, (username, pw_hash))
        conn.commit()
        conn.close()

        message = 'User created. <a href="/">Click Here</a> to log in.'
        message = {'message': message}
        return template('newuser', message)
    else:
        message = 'Passwords do not match. Please try again.'
        message = {'message': message}
        return template('newuser', message)

@route('/getweather', method='GET')
def cookie2():
    #verify cookie and redirect to default if needed
    if not request.get_cookie('COOKIE'):
        redirect('/')

@route('/getweather', method='POST')
def getweather():

    #get selection from user, create link to JSON object, convert to dictionary
    icao = request.forms.get('airports')
    url = "http://api.geonames.org/weatherIcaoJSON?ICAO=" + icao + "&username=jctcstudents"
    response = requests.get(url)
    data = response.json()
    
    #get weather information for chosen airport, convert units as needed
    stationName = data["weatherObservation"]["stationName"]
    elevation = data["weatherObservation"]["elevation"]
    elevation = round(float(elevation) * 3.28084, 1)
    clouds = data["weatherObservation"]["clouds"]
    dewPoint = data["weatherObservation"]["dewPoint"]
    dewPoint = round(float(dewPoint) * 1.8 + 32, 0)
    windSpeed = data["weatherObservation"]["windSpeed"]
    windSpeed = round(float(windSpeed) * 1.1508, 1)
    temperature = data["weatherObservation"]["temperature"]
    temperature = round(float(temperature) * 1.8 + 32, 0)
    humidity = data["weatherObservation"]["humidity"]

    #add data to tuple and send to table to display to user
    tpl = {'stationName': stationName, 'elevation': elevation, 'clouds': clouds, 'dewPoint': dewPoint, 'windSpeed': windSpeed, 'temperature': temperature, 'humidity': humidity}
    return template('weather', tpl)

def validate_user(username, password):
    #connect to database and verify user info
    conn = sqlite3.connect('userdata.sqlite')
    cur = conn.cursor()
    sql = 'SELECT id FROM users WHERE username = ? AND password = ?'
    cur.execute(sql, (username, password))
    user = cur.fetchone()
    conn.close()

    if not user:
        return False
    return True

    
def main():
    run(host='localhost', port=8080, reloader=True)

if __name__ == '__main__':
    main()