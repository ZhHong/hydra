export SECRETS_SYSTEM=yjd07eqW6nf9XzrhUK1QT6TLjpOgT9mB
export DSN="mysql://root:root@tcp(192.168.1.86:3306)/oauth?max_conns=20&max_idle_conns=4&parseTime=true"
export MY_HOST=127.0.0.1
export URLS_SELF_ISSUER=http://${MY_HOST}:4444/
export URLS_CONSENT=http://${MY_HOST}:9020/consent
export URLS_LOGIN=http://${MY_HOST}:9020/login

./hydra serve all --dangerous-force-http


export MY_HOST=127.0.0.1
./hydra clients create \
--endpoint http://${MY_HOST}:4445 \
--id id100023245 \
--secret wdawdadwadwadawd \
-g authorization_code,refresh_token \
-r token,code,id_token \
--scope openid,offline \
--callbacks http://${MY_HOST}:9010/callback


export MY_HOST=127.0.0.1
./hydra token user \
--port 9010 \
--auth-url http://${MY_HOST}:4444/oauth2/auth \
--token-url http://${MY_HOST}:4444/oauth2/token \
--client-id id100023245 \
--client-secret wdawdadwadwadawd \
--scope openid,offline \
--redirect http://${MY_HOST}:9010/callback