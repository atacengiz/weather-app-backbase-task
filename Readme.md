# Weather App for Backbase task

## Finished features

### Home screen

- Showing a list of locations that the user has bookmarked previously.
- Show a way to remove locations from the list
- Add locations by placing a pin on map.

### City screen

- Today’s forecast, including: temperature, humidity, wind information

### Help screen

- The help screen should be done using a webview, and contain information of how to use the app, gestures available if any, etc.

## Finished bonus features

### Settings Screen

- Settings page: where the user can select some preferences like: unit system(metric/imperial)

## Unfinished features

### Help screen

- Rain information: i was not able to understand api structure of rain because i called the api many different locations but rain field was not there in the response.

## Architecture

### MVP

- Information about MVP can be found at: <https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93presenter>. The reason behind this architecture decision is to make sure view controllers are light weight and easy to understand.

## Code coverage

- Code coverage is at %53. It could be much higher but because of time limitations, only test what i found most important. Pretty printed code coverage file can be found in the repository.

## Things i would have done

Because of time limitations, there are some decisions that would have been different.

- Using NSUserDefaults for storing searched cities, normally i would have used database for this.
- Storing the weather information class as it is in user defaults. I would have created a smaller structure inside of weather information structure and just store that.
- Lack of dependency injection for view controllers. I personally prefer using coordinator pattern to overcome this but did not have time to implement.
- Lack of network layer. Right now, there is no separate network layer and it is inside current city weather manager.