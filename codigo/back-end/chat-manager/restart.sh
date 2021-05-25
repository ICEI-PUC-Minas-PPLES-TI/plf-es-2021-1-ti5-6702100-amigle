date > README.md
git config user.email "agbranco@sga.pucminas.br"
git config user.name "arthurgbranco"
git add .
git commit -m "$(date)"
git push heroku master
heroku ps:scale web=1
