<!DOCTYPE html>
<html>
    <head>
        <title>Airport Information</title>
        <link rel="stylesheet" type="text/css" href="/static/style2.css">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300&display=swap" rel="stylesheet">
        <meta name="viewport" content="width=device-width,initial-scale=1">
    </head>
<body>
    <div class="weatherform">
        <form action='/getweather' method='post'>
        
        <select name="airports">
        <option value="EGPD">Aberdeen, Scotland</option>
        <option value="VIDP">New Delhi, India</option>
        <option value="LSZH">Zurich, Switzerland</option>
        <option value="RJAA">Tokyo, Japan</option>
        <option value="EFHK">Helsinki, Finland</option>
        <option value="LEMD">Madrid, Spain</option>
        <option value="KCVG">Cincinnati, United States</option>
        <option value="MMMX">Mexico City, Mexico</option>
        <option value="SKBO">Bogot&aacute;, Columbia</option>
        </select>


        <input value="Get Airport Data" type="submit" class="submit">
        </form>

        <table cellspacing = '6'>
        % if defined('stationName'):
        <tr><td>Station Name: </td> <td> {{stationName}} </td></tr>
        %end
        % if defined('elevation'):
        <tr><td>Elevation (ft.): </td> <td> {{elevation}} </td></tr>
        %end
        % if defined('dewPoint'):
        <tr><td>Dew point (&deg;F): </td> <td> {{dewPoint}} </td></tr>
        %end
        % if defined('clouds'):
        <tr><td>Clouds: </td> <td> {{clouds}} </td></tr>
        %end
        % if defined('windSpeed'):
        <tr><td>Wind Speed (mph): </td> <td> {{windSpeed}} </td></tr>
        %end
        % if defined('temperature'):
        <tr><td>Temperature (&deg;F): </td><td>{{temperature}} </td></tr>
        %end
        % if defined('humidity'):
        <tr><td>Humidity (%): </td><td>{{humidity}} </td></tr>
        %end

        </table>
    </div>
</body>
</html>