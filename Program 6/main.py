#sample user:
#username: admin
#password: default


import sqlite3
import hashlib
import uuid
from bottle import route, run, request, template, response

@route ('/', method='GET')
def index():
    return template('index')

@route('/login', method='POST')
def login():
    #get user info and hash password
    username = request.forms.get('username')
    password = request.forms.get('password')
    pw = password.encode('utf-8')
    pw_hash = hashlib.sha1(pw).hexdigest()

    #create cookie
    if validate_user(username, pw_hash):
        cookie_val = str(uuid.uuid4())
        response.set_cookie('COOKIE', cookie_val)
        return template('weather') 
    else:
        return '<p>Login Failed.</p>'

# @route('getweather', method='POST')
# def getweather():
#TODO: verify cookie and redirect to login if needed, get weather API and send to table for viewing


def validate_user(username, password):
    conn = sqlite3.connect('userdata.sqlite')
    cur = conn.cursor()
    sql = 'SELECT id FROM users WHERE username = ? AND password = ?'
    cur.execute(sql, (username, password))
    user = cur.fetchone()
    conn.close()

    if not user:
        return False
    return True

    

run(host='localhost', port=8080)