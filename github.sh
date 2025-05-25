git add .
echo enter commit comment
read comment
git commit -m "${comment}"
git push origin main