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

```
@def(head)
	<head>
		<meta charset="utf-8">
		<title>title</title>
		<link rel="stylesheet" href="vc.css">
	</head>
@end(head)
```

```
@Def(file: ../vc.css)
	@Put(css)
@End(file: ../vc.css)
```

```
@Def(file: ../vc.js)
	'use strict';
	@Put(js)
@End(file: ../vc.js)
```
