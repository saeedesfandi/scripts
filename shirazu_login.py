#Shiraz University Login Script
#By saeed.esfandi@gmail.com
#Version 0.1 beta (2015-05-22)

import sys
import md5
import re
import requests

#Your user & pass
user = raw_input('user:')
pass_raw = raw_input('pass:')

r = requests.get('http://ictc.hs/login')
print('login request: ' + str(r.status_code))    
#print(r.text)

st = r.text
start = st.find('name="chap-id" value="')
end = st.find('">', start)
chap_id = st[start+22:end]
print(chap_id)
chap_id = chap_id.decode('string-escape')

start = st.find('name="chap-challenge" value="')
end = st.find('">', start)
chap_challenge = st[start+29:end]
print(chap_challenge)
chap_challenge = chap_challenge.decode('string-escape')


pass_md5 = md5.new(chap_id + pass_raw + chap_challenge).hexdigest()
print(pass_md5)


param = {'username':user, 'password':pass_md5, 'dst':'', 'popup':'true'}
r = requests.post('http://ictc.hs/login', data = param)
print('login response: ' + str(r.status_code))
#print(r.text)


