# Used Files
* what files are used in this project

## Index HTML
* main entry to the app

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
* the JavaScript is the last part included, so its parsing does not
  slow down the rendering

```
@def(head)
	<head>
		<meta charset="utf-8">
		<title>Visual Cryptography</title>
		<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0"/>
		<link rel="stylesheet"
			href="vc.css">
	</head>
@end(head)
```
* the specifies a character set and a title
* also it includes the CSS file

```
@Def(file: ../vc.css)
	@Put(css)
@End(file: ../vc.css)
```
* global fragment for CSS entries

```
@Def(file: ../vc.js)
	'use strict';
	@Put(js)
@End(file: ../vc.js)
```
* global fragment for JavaScript entries

