# Used Files
* What files are used in this project

## Index HTML
* Main entry to the app

```
@Def(file: ../index.html)
	<!DOCTYPE html>
	<html lang="en">
		@put(head)
		<body>
			@Put(body)
			<script src="vc.js"></script>
		</body>
	</html>	
@End(file: ../index.html)
```
* HTML file consists for a head an a body
* The JavaScript is the last part included, so its parsing does not
  slow down the rendering

```
@def(head)
	<head>
		<meta charset="utf-8">
		<title>Visual Cryptography</title>
		<link rel="stylesheet"
			href="vc.css">
	</head>
@end(head)
```
* The specifies a character set and a title
* Also it includes the CSS file

```
@Def(file: ../vc.css)
	@Put(css)
@End(file: ../vc.css)
```
* Global fragment for CSS entries

```
@Def(file: ../vc.js)
	'use strict';
	@Put(js)
@End(file: ../vc.js)
```
* Global fragment for JavaScript entries

