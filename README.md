# OpenFoods

👋 Hi! Welcome to your iOS coding excercise.

This is a very simple application. We should have provided you with a unique URL for the API, this is just for you. You are asked to write the app that will display a list of foods from the API. The API also allows you to like and unlike foods.

## Solution

My solution is programmed using SwiftUI, and vanilla UIKit/Foundation APIs as much as possible.

The app was programmed using Xcode 14.3.1 with a minimum deployment target of 16.0.

Screenshots of the app:

<img src="https://github.com/runnersaw/OpenFoods/blob/main/screenshots/list_view.png?raw=true" alt="Image of the list of food in the app" style="max-width: 200px;">
<img src="https://github.com/runnersaw/OpenFoods/blob/main/screenshots/detail_view.png?raw=true" alt="Image of the detail view of a food item in the app" style="max-width: 200px;">
<img src="https://github.com/runnersaw/OpenFoods/blob/main/screenshots/error_view.png?raw=true" alt="Image of the error view displayed when fetching food fails" style="max-width: 200px;">

App capabilities:
- Fetch and display the list of food, including the name, description, image, country of origin, and like status of the food
- View the details of one item of food, including the full description
- Handles the failure to like or unlike a food item gracefully and alerts the user
- Handles a failure to fetch the list of food with a "Retry" button

Future work:
- Address race conditions in FoodRepository
- De-duplicate multiple image requests with the same URL (on list and detail view, for instance)

## Minimum requirement

- Fork or clone the repo
- Parse the list of foods.
- Display the foods in the order the service defines them. The app should display:
  - The name of the food.
  - The description of the food, this is variable length so the cells must be properly sized to the content or this can be truncated and the full description can be shown on another screen the user navigates to.
  - The country of origin, this could be the text, an emoji, an image or something else.
  - Do you like this food. This should be an image or a symbol of some kind.
- Handle any errors or slow requests gracefully.
- When done, send a pull request to this project or zip via email.

Keep in mind that the repo is public, so forking and sending a pull request will be shown in your public GitHub activity. If that doesn't work out for you for whatever reason, you can simply clone the repo locally, and submit your work back as a zip file to the recruiter/hiring manager.

You may use UIKit or SwiftUI for this exercise. The provided template uses UIKit, but if you would like to use SwiftUI, it may be simpler to create a new xcode project and submit that instead.

## Bonuses (in no particular order)

- Add a button to like or unlike a food and then reload the list of foods.
- Show the image of the food. (Feel free to use AFNetworking/AlamoFire or just use NSURLSession for that.)
- Show when the food was last updated.
- Animate or highlight a food when it is selected (e.g. make it "bigger", in an animated fashion.)
- Add tests.
- Anything else you might think of that showcases a UIKit feature: UIDynamics, parallax effect, the list is endless.

## What the assignment will be judged on

- Accuracy of the result (e.g. is the cell sizing pixel perfect, dates are properly formatted, the app doesn't crash, project builds and runs with no extra step, etc.)
- Proper usage of UIKit apis (e.g. are cells properly reused, a back button must have a proper title, how well does it scale to various device sizes, etc.)
- Overall code quality: clarity, conciseness, quality of comments. Robustness and maintainability matter a lot more than clever one liners.
- If you end up short on time and/or can't fix a specific bug or finish a given feature, update this readme with what the bug is, and how you think you can fix had you more time.
- Bonuses are exactly that, bonuses. If you can complete one or more, good. Otherwise, don't sweat it.
- If you can't complete something, explain why, how you reached that conclusion and potential options to complete it.

## What the assignment will not be judged on

- Visual design. This is a UI coding excercise, not a visual design excercise.
- UI performance (e.g. framerate), as long as it's reasonable. Feel free to indicate in the code if/why something would affect the framerate, and a potential solution to it.
- If you try to complete a bonus and can't finish it, that's fine. I'd recommend using git commits/tags to indicate where the bonuses start in the history, so we can easily reset the branch at that commit and validate the minimum requirement.

## API

You recruiter/hiring manager should share with you a unique URL for the API. `userId` below is unique to you. You will find that in the unique URL provided, the API will not work without this. If you have any issues please reach out over email.

### Food

You can `GET` a list of foods from `api/v1/<userId>/food`.

This API will give you a list of foods. Sometimes this service can take awhile to respond. A food has at the minimum:

- `id` - You can use this to like and unlike foods.
- `name` - Name of the food.
- `isLiked` - Do you like this?
- `photoURL` - An absolute URL to an image of food that _probably_ exists.
- `description` - A description of the food. This could be empty or a very long string.
- `countryOfOrigin` - An ISO-3166-1 Alpha-2 code of a country that is _almost always_ real.
- `lastUpdatedDate` - When the food was added to the system or when you last liked or unliked it in the standard ISO-8601 format.

```json
{
  "id": 99,
  "name": "French Onion Soup",
  "isLiked": false,
  "photoURL": "https://opentable-dex-ios-test-000000000000.herokuapp.com/images/soup.jpg",
  "description": "French onion soup is a soup usually based on meat stock and onions, and often served gratinéed with croutons or a larger piece of bread covered with cheese floating on top. Ancient in origin, the dish underwent a resurgence of popularity in the 1960s in the United States due to a greater interest in French cuisine. French onion soup may be served as a meal in itself or as an entrée.",
  "countryOfOrigin": "FR",
  "lastUpdatedDate": "1970-01-01T00:00:00.000Z"
}
```

### Like

You can `PUT` a like to `api/v1/<userId>/food/<id>/like` to set `isLiked` to `true` and update `lastUpdatedDate` to now. This service _usually_ works but can throw errors sometimes. If the food has been succesffuly updated the value of `success` will be `true`

```json
{ "success": true }
```

### Unlike

You can `PUT` an unlike to `api/v1/<userId>/food/<id>/unlike` to set `isLiked` to `false` and update `lastUpdatedDate` to now. This service _usually_ works but can throw errors sometimes. If the food has been succesffuly updated the value of `success` will be `true`

```json
{ "success": true }
```

## Fin

Happy coding!
