# Draw two images over each other
* the images will be automatically generated from a reference image

```
@Def(body)
	<div>
		<canvas id="img-a"
			class="separate"
		></canvas><canvas id="img-b"
			class="separate"></canvas>
	</div><div>
		<img id="ref" src="ref.png">
	</div>
@End(body)
```
* body contains two diffs: one for the generated images and one for
  the reference image

```
@Def(css)
	img, canvas {
		-ms-interpolation-mode: nearest-neighbor;
		image-rendering: -webkit-optimize-contrast;
		image-rendering: -moz-crisp-edges;
		image-rendering: -o-pixelated;
		image-rendering: pixelated;
	}
	#img-a, div {
		position: relative;
	}
	#img-b {
		position: absolute;
	}
	#img-b.overlay {
		left: 0px;
		transition: left 2s linear;
	}
@End(css)
```
* First hard-code positions to force an overlay

```
@Add(css)
	#img-b.separate {
		left: 420px;
		transition: left 2s linear;
	}
@End(css)
```
* second hard-code positions to force separation overlay

```
@Def(js)
	const $ = xp => {
		return document.getElementById(
			xp.substr(1)
		);
	};
@End(js)
```
* helper function to get DOM elements
* similar to jQuery's method but only for IDs

```
@Add(js)
	window.addEventListener(
		'load', () => {
			@Put(main);
		}
	);
@End(js)
```
* perform the JavaScript stuff after the page is fully loaded

```
@Def(main)
	const $ref = $('#ref');
	const $img_a = $('#img-a');
	const $img_b = $('#img-b');
@End(main)
```
* get DOM elements

```
@Add(main)
	const refresh = () => {
		@Put(refresh)
	};
	refresh();
@End(main)
```

```
@Def(refresh)
	const w = ref.width + (ref.width % 2);
	const h = ref.height;
@End(refresh)
```
* reference Image specifies the size of the images
* width must be even, so it may be padded by a pixel

```
@Add(refresh)
	const ref_c =
		document.createElement('canvas');
	ref_c.width = $img_a.width =
		$img_b.width = w;
	ref_c.height = $img_a.height =
		$img_b.height = h;
@End(refresh)
```
* generate a hidden canvas to contain the reference image
* it is set to the correct size
* and the other canvases (that contain the generated images) are also
  set to their proper size

```
@Add(refresh)
	const ref_ctx =
		ref_c.getContext('2d');
	ref_ctx.drawImage($ref, 0, 0, w, h);
@End(refresh)
```
* reference image is drawn in the hidden canvas

```
@Add(refresh)
	const ref_id =
		ref_ctx.getImageData(0, 0, w, h);
	const ref_d = ref_id.data;
@End(refresh)
```
* the pixel array of the hidden canvas is used to generate the two
  randomized images

```
@Add(refresh)
	const getBlack = ctx => {
		const id =
			ctx_a.createImageData(1,1);
		const d = id.data;
		d[0] = d[1] = d[2] = 0;
		d[3] = 255;
		return id;
	};
@End(refresh)
```
* create one black pixel for a canvas object

```
@Add(refresh)
	const ctx_a = $img_a.getContext('2d');
	let black_a = getBlack(ctx_a);
	const ctx_b = $img_b.getContext('2d');
	let black_b = getBlack(ctx_b);
@End(refresh)
```
* create black pixels for both canvases

```
@Add(refresh)
	const gcd = (a, b) => {
		while (b != 0) {
			const t = a % b;
			a = b; b = t;
		}
		return a;
	};

	let x = 0;
	let y = 0;
	let m = w * h;
	let c = m;
	let d = Math.trunc(m/7);
	while (gcd(d, m) != 1) { ++d; }

	const draw = () => {
		for (let k = 0; c > 0 && k < 345; ++k) {
			let r = (y * w + x) * 4;
			@put(draw);
			--c;
			let i = y * w + x;
			i = i + d;
			while (i > m) { i -= m; }

			y = Math.floor(i / w);
			x = i - w * y;
		}
		if (c > 0) {
			setTimeout(draw, 0);
		}
	};
	draw();

@End(refresh)
```
* iterate over each pixel pair

```
@def(draw)
	let v = 0;
	for (let i = 0; i < 2; ++i) {
		let vv = 0;
		for (let j = 0; j < 3; ++j) {
			vv += ref_d[r++];
		}
		v += vv * ref_d[r++] / 255;
	}
@end(draw)
```
* sum over pixel pair in reference image
* the sums of a pixel are weighted by their alpha component

```
@add(draw)
	const putPixel = (x1, x2, y, v) => {
		ctx_a.putImageData(
			black_a, x1, y
		);
		ctx_b.putImageData(
			black_b,
			(v < 255 + 128) ? x2 : x1,
			y
		);
	};
@end(draw)
```
* depending of the reference pixel value put the black pixel in the same
  or different positions in the two images

```
@add(draw)
	if (Math.random() < 0.5) {
		putPixel(x, x + 1, y, v);
	} else {
		putPixel(x + 1, x, y, v);
	}
@end(draw)
```
* choose randomly where to put the pixel in the first image

## Move Images
* add buttons to move the images away from each other

```
@Add(body)
	<form>
	<button id="overlay">Overlay</button>
	<button
		id="separate">Separate</button>
	<input id="upload" type="file" />
	</form>
@End(body)
```
* two buttons for fixed positions

```
@Add(main)
	$('#overlay').addEventListener(
		'click',
		evt => {
			evt.preventDefault();
			$img_a.className = 'overlay';
			$img_b.className = 'overlay';
			$img_b.style.removeProperty('left');
			$img_b.style.removeProperty('top');
		}
	);
@end(main)
```
* move images into overlay position

```
@Add(main)
	$('#separate').addEventListener(
		'click',
		evt => {
			evt.preventDefault();
			$img_a.className = 'separate';
			$img_b.className = 'separate';
			$img_b.style.removeProperty('left');
			$img_b.style.removeProperty('top');
		}
	);
@end(main)
```
* move images in separate positions

## Move elements
* move the images with the mouse

```
@Add(main) {
	@put(mouse move);
} @End(main)
```
* put all moving parts in its own scope
* so that variables are local and do not pollute the global namespace

```
@def(mouse move)
	let mouse_down = false;
	let x = 0;
	let y = 0;
@end(mouse move)
```
* keep track if the mouse button is pressed
* and the origin of a mouse move

```
@add(mouse move)
	$img_b.addEventListener('mousedown', function (e) { 
		mouse_down = true; 
		x = $img_b.offsetLeft - e.clientX; 
		y = $img_b.offsetTop - e.clientY; 
		$img_b.className = '';
		$img_b.style.left = e.clientX + x + 'px'; 
		$img_b.style.top = e.clientY + y + 'px'; 
	}, true); 
	$img_b.addEventListener('mouseup', function (e) { 
		mouse_down = false; 
	}, true); 
	$img_b.addEventListener('mousemove', function (e) { 
		if (mouse_down) { 
			$img_b.style.left = e.clientX + x + 'px'; 
			$img_b.style.top = e.clientY + y + 'px'; 
		} 
	}, true); 
@end(mouse move)
```

```
@Add(main) {
	$('#upload').addEventListener('change', function () {
		if (this.files && this.files[0]) {
			$ref.onload = refresh;
			$ref.src = URL.createObjectURL(this.files[0]);
		}
	});
} @End(main)
```
