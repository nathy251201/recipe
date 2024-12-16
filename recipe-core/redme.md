## Para fazer o push é necessario entrar no dockerhub
 docker login

## Para build da imagem executar o comando
```
docker build <usuário_dockerhub>/<nome_image_image>:<tag>
```

exemplo de comando
``` 
docker build -t kamyokazem/recipe-core:latest .
```
 docker build -t kamyokazem/recipe-core:latest .
 ## Agora fazer o push da imagem para o  resgistry do docker hub
 exemplo de comando
```
docker push kamyokazem/recipe-core:latest
```


