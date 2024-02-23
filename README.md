# Weather73

This application simply allows the user to enter an address and get the 
temperature for that address. The weather is cached for 30 minutes and
then updated by a DelayedJob. 


# Configuration
You need to set the GOOGLE_MAPS_KEY environment variable with a valid API
key from Google.

You need to set the WEATHER_KEY environment variable with a valid API key
from OpenWeatherMap.

After deployment ensure that you start the job to update the weather:
`UpdateWeatherJob.set(wait: 1.minute).perform_later`

# Weather Notes
The API call being used currently gets the high and low for the area for the
current temperature. This isn't a daily high/low