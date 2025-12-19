# Define the request URL with your API key and units (metric)
URL="https://api.openweathermap.org/data/2.5/weather?q=Austin,US&units=metric&appid=c95d0df646a53e11899ae8dc2099ed62"

# Fetch the weather data silently using curl
response=$(curl -s "${URL}")

# Extract the temperature, weather description, and weather condition code using jq
temp=$(echo "${response}" | jq '.main.temp')
desc=$(echo "${response}" | jq -r '.weather[0].description')
code=$(echo "${response}" | jq '.weather[0].id')

# Convert temperature to an integer for a cleaner display
temp_int=$(printf "%.0f" "$temp")

# Determine a fun emoji based on the weather condition code:
if [ "$code" -ge 200 ] && [ "$code" -le 232 ]; then
    emoji="⛈️"  # Thunderstorm
elif [ "$code" -ge 300 ] && [ "$code" -le 321 ]; then
    emoji="🌦️"  # Drizzle
elif [ "$code" -ge 500 ] && [ "$code" -le 531 ]; then
    emoji="🌧️"  # Rain
elif [ "$code" -ge 600 ] && [ "$code" -le 622 ]; then
    emoji="❄️"  # Snow
elif [ "$code" -ge 701 ] && [ "$code" -le 781 ]; then
    emoji="🌫️"  # Atmosphere (mist, smoke, etc.)
elif [ "$code" -eq 800 ]; then
    emoji="☀️"  # Clear
elif [ "$code" -eq 801 ]; then
    emoji="🌤️"  # Few clouds
elif [ "$code" -eq 802 ]; then
    emoji="⛅"   # Scattered clouds
elif [ "$code" -eq 803 ]; then
    emoji="🌥️"  # Broken clouds
elif [ "$code" -eq 804 ]; then
    emoji="☁️"  # Overcast
else
    emoji="🌡️"  # Fallback for unexpected codes
fi

# Output the weather report with fun emojis:
echo "${temp_int}°C $emoji"
echo "${desc^^}"
