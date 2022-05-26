# instructions

- Open folder in vscode
- start web server ("go live")

```
window.fetch("http://localhost:5555/index.html")
.then(result => result.text())
    .then(res => console.log(res))
.catch(console.error);
```

window.fetch("http://localhost:5555/example.json")
.then(result => result.json())
    .then(res => console.log(res))
.catch(console.error);


window.fetch("http://localhost:5555/example.json")
.then(result => result.json())
    .then(res => console.log(res.name))
.catch(console.error);