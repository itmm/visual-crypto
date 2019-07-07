# Draw two images over each other
* The images will be automatically generated from a reference image

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
* Body contains two diffs: one for the generated images and one for
  the reference image

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
* First hard-code positions to force an overlay

```
@Def(js)
	const $ = xp => {
		return document.getElementById(
			xp.substr(1)
		);
	};
@End(js)
```
* Helper function to get DOM elements
* Similar to jQuery's method but only for IDs

```
@Add(js)
	window.addEventListener(
		'load', () => {
			@Put(main);
		}
	);
@End(js)
```
* Perform the JavaScript stuff after the page is fully loaded

```
@Def(main)
	const $ref = $('#ref');
	const $img_a = $('#img-a');
	const $img_b = $('#img-b');
@End(main)
```
* Get DOM elements

```
@Add(main)
	const w = ref.width + (ref.width % 2);
	const h = ref.height;
@End(main)
```
* Reference Image specifies the size of the images
* Width must be even, so it may be padded by a pixel

```
@Add(main)
	const ref_c =
		document.createElement('canvas');
	ref_c.width = $img_a.width =
		$img_b.width = w;
	ref_c.height = $img_a.height =
		$img_b.height = h;
@End(main)
```
* Generate a hidden canvas to contain the reference image
* It is set to the correct size
* And the other canvases (that contain the generated images) are also
  set to their proper size

```
@Add(main)
	const ref_ctx =
		ref_c.getContext('2d');
	ref_ctx.drawImage($ref, 0, 0, w, h);
@End(main)
```
* Reference image is drawn in the hidden canvas

```
@Add(main)
	const ref_id =
		ref_ctx.getImageData(0, 0, w, h);
	const ref_d = ref_id.data;
@End(main)
```
* The pixel array of the hidden canvas is used to generate the two
  randomized images

```
@Add(main)
	const getBlack = ctx => {
		const id =
			ctx_a.createImageData(1,1);
		const d = id.data;
		d[0] = d[1] = d[2] = 0;
		d[3] = 255;
		return id;
	};
@End(main)
```
* Create one black pixel for a canvas object

```
@Add(main)
	const ctx_a = $img_a.getContext('2d');
	let black_a = getBlack(ctx_a);
	const ctx_b = $img_b.getContext('2d');
	let black_b = getBlack(ctx_b);
@End(main)
```
* Create black pixels for both canvases

```
@Add(main)
	let r = 0;
	for (let y = 0; y < h; ++y) {
		for (let x = 0; x < w; x += 2) {
			@put(draw);
		}
	}
@End(main)
```
* Iterate over each pixel pair

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
* Sum over pixel pair in reference image
* The sums of a pixel are weighted by their alpha component

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
* Depending of the reference pixel value put the black pixel in the same
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
* Choose randomly where to put the pixel in the first image

