# Draw two images over each other

```
@Def(body)
	<div>
		<canvas id="img-a"></canvas>
		<canvas id="img-b"></canvas>
	</div><div>
		<img id="ref" src="ref.png">
	</div>
@End(body)
```

```
@Def(css)
	#img-b {
		position: relative;
	}
	#img-a {
		position: absolute;
	}
@End(css)
```

```
@Def(js)
	const $ = xp => {
		return document.getElementById(
			xp.substr(1)
		);
	};
@End(js)
```

```
@Add(js)
	window.addEventListener(
		'load', () => {
			@Put(main);
		}
	);
@End(js)
```

```
@Def(main)
	const $ref = $('#ref');
	const $img_a = $('#img-a');
	const $img_b = $('#img-b');
@End(main)
```

```
@Add(main)
	const ref_c = document.createElement('canvas');
	const w = ref.width + (ref.width % 2);
	const h = ref.height;
	ref_c.width = $img_a.width = $img_b.width = w;
	ref_c.height = $img_a.height = $img_b.height = h;
	ref_c.getContext('2d').drawImage($ref, 0, 0, w, h);
	const ref_d = ref_c.getContext('2d').getImageData(0, 0, w, h).data;
@End(main)
```

```
@Add(main)
	const ctx_a = $img_a.getContext('2d');
	let black_a = ctx_a.createImageData(1,1);
	black_a.data[0] = black_a.data[1] = black_a.data[2] = 0;
	black_a.data[3] = 255;
	const ctx_b = $img_b.getContext('2d');
	let black_b = ctx_b.createImageData(1,1);
	black_b.data[0] = black_b.data[1] = black_b.data[2] = 0;
	black_b.data[3] = 255;
	let r = 0;
	for (let y = 0; y < h; ++y) {
		for (let x = 0; x < w; x += 2) {
			let v = 0;
			for (let i = 0; i < 2; ++i) {
				for (let j = 0; j < 3; ++j) {
					v += ref_d[r++];
				}
				++r;
			}
			if (Math.random() > 0.5) {
				ctx_a.putImageData(black_a, x, y);
				if (v < 255 + 128) {
					ctx_b.putImageData(black_b, x + 1, y)
				} else {
					ctx_b.putImageData(black_b, x, y)
				}
			} else {
				ctx_a.putImageData(black_a, x + 1, y);
				if (v < 255 + 128) {
					ctx_b.putImageData(black_b, x, y)
				} else {
					ctx_b.putImageData(black_b, x + 1, y)
				}
			}
		}
	}
@End(main)
```
