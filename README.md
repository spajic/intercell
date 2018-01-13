## Setup app
`rails new app --skip-coffee --skip-sprockets --webpack=react --database=postgresql -T`

create file `browserlist.rc` containing `> 1%`

in `application.rb`

```ruby
config.generators do |g|
  g.system_tests    nil
  g.test_framework  false
  g.stylesheets     false
  g.javascripts     false
  g.helper          false
  g.channel         assets: false
end
```

```bash
rm app/assets
mv app/javascript frontend
```

```ruby
# in application.html
javascript_include_tag -> javascript_pack_tag # and move after yield yet
stylesheet_include_tag -> stylesheet_pack_tag
```

```ruby
# in config/webpacker.yml
source_path: frontend

# in application_controller
prepend_view_path Rails.root.join('frontend')

# in Procfile to use via Overmind
server: bin/rails server
assets: bin/webpack-dev-server
```

```javascript
// package.json for eslint with airbnb, prettier, lint-staged, pre-commit, sytlelint for css, lint-staged hook
{
  "name": "app",
  "private": true,
  "dependencies": {
    "@rails/webpacker": "^3.2.0",
    "normalize.css": "^7.0.0"
  },
  "devDependencies": {
    "babel-cli": "^6.26.0",
    "babel-eslint": "^8.0.1",
    "babel-preset-react": "^6.24.1",
    "eslint": "^4.8.0",
    "eslint-config-airbnb-base": "^12.0.1",
    "eslint-config-prettier": "^2.6.0",
    "eslint-import-resolver-webpack": "^0.8.3",
    "eslint-plugin-import": "^2.7.0",
    "eslint-plugin-prettier": "^2.3.1",
    "lint-staged": "^4.2.3",
    "pre-commit": "^1.2.2",
    "prettier": "^1.7.3",
    "stylelint": "^8.1.1",
    "stylelint-config-standard": "^17.0.0",
    "webpack-dev-server": "^2.9.1"
  },
  "scripts": {
    "lint-staged": "$(yarn bin)/lint-staged"
  },
  "lint-staged": {
    "config/webpack/**/*.js": [
      "prettier --write",
      "eslint",
      "git add"
    ],
    "frontend/**/*.js": [
      "prettier --write",
      "eslint",
      "git add"
    ],
    "frontend/**/*.css": [
      "prettier --write",
      "stylelint --fix",
      "git add"
    ]
  },
  "pre-commit": [
    "lint-staged"
  ]
}

```

```javascript
// .eslintrc
{
  "extends": ["eslint-config-airbnb-base", "prettier"],

  "plugins": ["prettier"],

  "env": {
    "browser": true
  },

  "rules": {
    "prettier/prettier": "error"
  },

  "parser": "babel-eslint",

  "settings": {
    "import/resolver": {
      "webpack": {
        "config": {
          "resolve": {
            "modules": ["frontend", "node_modules"]
          }
        }
      }
    }
  }
}
```

```javascript
// .stylelintrc
{
  "extends": "stylelint-config-standard"
}
```


```bash
rails g controller pages home
```

```ruby
# in routes
root to: 'pages#home'
```

```javascript
// in frontend/packs/application.js
import "init";
import "components/page/page";

// in frontend/init/index.js
import "./index.css";
```

```css
/* frontend/init/index.css */
@import "normalize.css/normalize.css";

body {
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 16px;
  line-height: 24px;
}
```

```bash
$ mkdir -p frontend/components/page
$ touch frontend/components/page/{_page.html.erb,page.css,page.js}
```

```javascript
// in page.js
import "./page.css";
```

```css
.page {
  height: 100vh;
  width: 700px;
  margin: 0 auto;
  overflow: hidden;
}
```

```erb
# page.html.erb
<div class="page">
  <%= yield %>
</div>
```


## Resources

### Github
- https://github.com/rails/webpacker
- https://github.com/shakacode/react_on_rails
- https://github.com/reactjs/react-rails
- https://github.com/airbnb/hypernova
- https://github.com/airbnb/hypernova-ruby
- https://github.com/discourse/mini_racer - Minimal embedded v8 for Ruby used in react-on-rails, react-rails (alt to therubyracer)
- https://github.com/prerender/prerender Node server that uses Headless Chrome to render a javascript-rendered page as HTML. To be used in conjunction with prerender middleware.
- https://github.com/prerender/prerender_rails Rails middleware gem for prerendering javascript-rendered pages on the fly for SEO

### Evil-front
- https://evilmartians.com/chronicles/evil-front-part-1
- https://evilmartians.com/chronicles/evil-front-part-2
- https://evilmartians.com/chronicles/evil-front-part-3

### Services
- https://prerender.io/

### Articles
- https://hackernoon.com/whats-new-with-server-side-rendering-in-react-16-9b0d78585d67
- https://robots.thoughtbot.com/how-we-replaced-react-with-phoenix
- https://blog.codeship.com/server-rendering-react-on-rails/ - Leigh Halliday
- https://tomdale.net/2015/02/youre-missing-the-point-of-server-side-rendered-javascript-apps/ - Misconceptions on server rendering
- https://product.reverb.com/react-on-rails-9936283aea07 - React on Rails from Reverb (part 1) - NodeJs service via Unix socket
- https://product.reverb.com/bridging-rails-nodejs-with-grpc-5cb58e03189c - React on Rails from Reverb (part 2) - Enter gRPC to glue Rails and Node.js

### Videos
- https://www.youtube.com/watch?v=x7cQ3mrcKaY
