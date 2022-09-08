<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Airport Information</title>
        <link rel="stylesheet" type="text/css" href="/static/style2.css">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300&display=swap" rel="stylesheet">
        <meta name="viewport" content="width=device-width,initial-scale=1">
    </head>
<body>
    <div class="weatherform">
        <form action='/getweather' method='post'>
        
        <select name="cities">
        <option value="lat=57.149715&lon=-2.094278">Aberdeen, Scotland</option>
        <option value="lat=28.632429&lon=77.218788">New Delhi, India</option>
        <option value="lat=47.376888&lon=8.541694">Zurich, Switzerland</option>
        <option value="lat=35.689487&lon=139.691711">Tokyo, Japan</option>
        <option value="lat=60.169857&lon=24.938379">Helsinki, Finland</option>
        <option value="lat=40.4168&lon=3.7038">Madrid, Spain</option>
        <option value="lat=39.1031&lon=84.5120">Cincinnati, United States</option>
        <option value="lat=19.4326&lon=99.1332">Mexico City, Mexico</option>
        <option value="lat=4.7110&lon=74.0721">Bogot&aacute;, Columbia</option>
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
