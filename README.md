# dycksoft blog

Super simple static site generator using markdown for the source files, ruby for HTML file generation, and nginx for hosting.

This blog will be hosted at https://dycksoft.com/blog.

## Layout

All posts will be stored in the `src` directory as the raw markdown files, which is what they will be written in by default. 
These markdown posts will be converted to static HTML files and stored in the `dist` directory so that we always have a copy of the served posts in source control.

## Commands

In the bin directory there are two scripts.

`gen` will generate the static HTML files to be served using the markdown files in the `src` directory plus the `layout.html` file.
All posts will use the same layout, as specified in the `layout.html` file.

`deploy` deploys the static files to my server, which is just serving them via nginx.
The deploy script assumes that you have rsync installed on your local machine.
