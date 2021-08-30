# DOJ - DOnlineJudge
<div align="center">
<img src="https://user-images.githubusercontent.com/24392632/131251506-b7b54b9a-319e-4002-96bc-87122a3dadd7.png" alt="DOnlineJudge's Logo">
</div>

A modern online judge that is developed using ReactJS and Django REST API Framework. Our motive is To further understand about Online Judges, we have built our own OJ system, taking a different technical approach when compare to others.

See it in action [here](http://45.117.171.223:8080/).

## Features
The current version consists of a small set of functionality, though very necessary and allows us to demonstrate the core features our system can do.

* A bulletin board to post announcements
* Rich problem statements, with support for LaTeX math
* Support popular programming language: `C, C++, Python, Java`
* Rich, comprehensive submission status page
* Great Permission controls for staffs

## Screenshots
### Front Page
* Greeting message and the system's bulletin board.

![Front page](https://raw.githubusercontent.com/nvatuan/PBL-DOnlineJudge/tmp/screenshots/front.png)

### Problems
* Rich Search, Filtering tools to help finding the correct problem.

![Problem](https://raw.githubusercontent.com/nvatuan/PBL-DOnlineJudge/tmp/screenshots/problem.png)

* Supports LaTex for better paragraph styling and math expression

![Problem Details](https://raw.githubusercontent.com/nvatuan/PBL-DOnlineJudge/tmp/screenshots/problem-de.png)

### Submission Status
* Rich Search and Filtering tools

![Status](https://raw.githubusercontent.com/nvatuan/PBL-DOnlineJudge/tmp/screenshots/status-searching.png)

* Comprehensive Submission details

![Status Detail](https://raw.githubusercontent.com/nvatuan/PBL-DOnlineJudge/tmp/screenshots/status-de.png)


### Staff Page
The DOJ admin interface is versatile, and can be efficiently used for anything from managing users to authoring problem statements, auditting submissions,..
* Admin dashboard with useful information and a Control Panel (on the left side)

![Admin Dash](https://raw.githubusercontent.com/nvatuan/PBL-DOnlineJudge/tmp/screenshots/admin-dash.png)

* Control what is public via Visibility

![Admin Announcement](https://raw.githubusercontent.com/nvatuan/PBL-DOnlineJudge/tmp/screenshots/admin-prob.png)

* Easy-to-use, friendly interface

![Admin Problem Create](https://raw.githubusercontent.com/nvatuan/PBL-DOnlineJudge/tmp/screenshots/admin-prob-create.png)

* Control over submissions

![Admin Submission](https://raw.githubusercontent.com/nvatuan/PBL-DOnlineJudge/tmp/screenshots/admin-submission-de.png)

## Installation
Our project has 3 components that you will need to run separately:
### Web-server (`build` folder)
This is our site, we will need to serve this folder. One simple way to do it is to [install npm module](https://www.npmjs.com/package/express) `express`, then place the following script `serve.js` in the same folder with the `build` folder. And start the server with `node serve.js`. 
<details>
  <summary> serve.js </summary>

  ```js
  var path = require('path');
  var express = require('express');
  var app = express();

  app.use(express.static(path.resolve(__dirname, 'build')));
  app.get('*', (req, res) => {
      res.sendFile(path.resolve(__dirname, 'build', 'index.html'));
  });

  var server = app.listen(8080)
  ```

</details>

### API Server (`donlinejudge` folder)
For this, we need Python 3.8's `django` module. There are some more dependencies we have yet to note it down, but you can install them as you go because `django` will let you know what you are missing. Also, the backend uses `Postgresql` (version 13), make sure you install it as well.
To start the backend, run the following commands:
1. Migrate the database if you haven't:
```python
python manage.py makemigrations
python manage.py migrate
```
2. Start the backend
```python
python manage.py runserver 0.0.0.0:5000
```
Will run the API server on port `5000`.

### Judge Server (`dockerjudge` folder)
We have yet to document the dependencies, some major ones you will need are:
- Docker engine
- `websockets` module
Then download the `dockerjudge` folder and run this command from the **parent** directory:
```python
python -m dockerjudge 127.0.0.1:5001
```
This command will run it *as an module*, start the judge server and listening to port `5001`. Though the module needs some time to warm up first (initialize the Docker containers).

## Technical/System Analysis
For more information, (eg. how our system was built, and how it performs,...) you can check them [here (.PDF)](https://github.com/nvatuan/PBL-DOnlineJudge/raw/tmp/DOnlineJudge%20System%20Technical%20(Eng).pdf).

## Development branches
- For DOJ's website interface related issues, please refer to [dev-frontend](https://github.com/nvatuan/PBL_DOnlineJudge/tree/dev-frontend)
- For DOJ's webserver-related issues, please refer to [dev-backend](https://github.com/nvatuan/PBL_DOnlineJudge/tree/dev-backend)
- For DOJ's Judge Server related issues, please refer to [judgeserver](https://github.com/nvatuan/PBL_DOnlineJudge/tree/dev-judgeserver)
