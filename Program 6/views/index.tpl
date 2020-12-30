<html>
    <head>
        <title>Login form</title>
        <link rel="stylesheet" type="text/css" href="/static/style.css">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300&display=swap" rel="stylesheet">
        <meta name="viewport" content="width=device-width,initial-scale=1">
    </head>
<body>

  <div class="signin">
    <h2>Log in.</h2>
    <form action="/login" method="post">
        <p><input name="username" type="text" size="20" placeholder="User Name"></p>
        <p><input name="password" type="password" size="20" placeholder="Password"></p>
        <p><input type="submit" class="submit"></p>

    </form>
    <p id="text">New user? <a href="/newuser">Click Here</a> to create an account!</p>
  </div>

</body>
</html>