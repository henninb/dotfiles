export const html = `
<html lang="en">
  <head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
    <title>Home</title>
    <style>
    @import url(https://fonts.googleapis.com/css2?family=Comfortaa&display=swap);
body {
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Oxygen, Ubuntu, Cantarell, Fira Sans, Droid Sans, Helvetica Neue, sans-serif;
    margin: 0;
    background: linear-gradient(90deg, #4b6cb7, #182848);
}

code {
    font-family: source-code-pro, Menlo, Monaco, Consolas, Courier New, monospace
}

.form-icon {
    font-size: 14px;
}

.login {
    font-family: Comfortaa, cursive;
    margin: auto;
    padding: 8% 0 0;
    width: 360px
}

.form {
    background: #fff;
    border-radius: 10px;
    margin: 0 auto 100px;
    max-width: 360px;
    padding: 45px;
    position: relative;
    text-align: center;
    z-index: 1;
}

.form input {
    background: #f2f2f2;
    border: 0;
    border-radius: 5px;
    box-sizing: border-box;
    font-family: Comfortaa, cursive;
    font-size: 14px;
    margin: 0 0 15px;
    outline: 0;
    padding: 15px;
    width: 100%;
}

.form input:focus {
    background: #dbdbdb
}

.form button {
    background: #4b6cb7;
    border: 0;
    border-radius: 5px;
    color: #fff;
    cursor: pointer;
    font-family: Comfortaa, cursive;
    font-size: 14px;
    outline: 0;
    padding: 15px;
    text-transform: uppercase;
    transition: all .3 ease;
    width: 100%
}

.form button:active {
    background: #395591
}

.form span {
    color: #4b6cb7;
    font-size: 75px;
}
    </style>
  </head>
  <body>

      <div>
      <nav class="navbar navbar-expand-lg navbar-light navbar-fixed-top">
        <button
          class="navbar-toggler"
          type="button"
          data-toggle="collapse"
          data-target="#navbarNav"
          aria-controls="navbarNav"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon" />
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav">
            <li class="nav-item active">
              <a class="nav-link" href="/">
                Home<span class="sr-only">(current)</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/payments">
                Payments
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/payment/required">
                Payment Required
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/freeform">
                FreeForm
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/login">
                Login
              </a>
            </li>
          </ul>
        </div>
      </nav>
    </div>

          <div class="login">
            <div class="form">
                <form name="login-form" class="login-form" action="/login" method="GET" data-bitwarden-watching="1">
                    <span class="material-icons">lock</span>
                    <div class="input-group mb-3">
                <div class="input-group-prepend">
                 <span class="input-group-text">
                  <i class="fa fa-user form-icon"></i>
                 </span>
                </div>
                <input type="text" class="form-control" placeholder="Email" id="email" name="email" />
             </div>
             <div class="input-group mb-3">
               <div class="input-group-prepend">
                 <span class="input-group-text">
                   <i class="fa fa-lock form-icon"></i>
                 </span>
               </div>
               <input type="password" class="form-control" placeholder="Password" id="password" name="password" />
             </div>
                    <button type="submit">login</button>
                </form>
            </div>
        </div>
  </body>
</html>
`
