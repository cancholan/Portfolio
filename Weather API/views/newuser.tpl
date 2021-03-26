<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link rel="stylesheet" type="text/css" href="/static/style.css">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300&display=swap" rel="stylesheet">
        <title>Create User</title>
    </head>
<body>

  <div class="signin">
    <h2>Create New User</h2>
    <form action="/createuser" method="post">

        <input name="newuser" type="text" size="20" placeholder="User Name"> 
        <input name="newpass" type="password" size="20" placeholder="Password"> 
        <input name="newpass2" type="password" size="20" placeholder="Confirm Password"> 
        <input type="submit"class="submit">

    </form>
    % if defined('message'):
    <p class="warning"><a href="/">{{message}}</a></p>
    %end
    % if defined('warning'):
    <p class="warning">{{warning}}</p>
    %end
</div>
</body>
</html>