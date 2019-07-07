
	'use strict';
	
	const $ = xp => {
		return document.getElementById(
			xp.substr(1)
		);
	};

	window.addEventListener(
		'load', () => {
			
	const $ref = $('#ref');
	const $img_a = $('#img-a');
	const $img_b = $('#img-b');

	const w = ref.width + (ref.width % 2);
	const h = ref.height;

	const ref_c =
		document.createElement('canvas');
	ref_c.width = $img_a.width =
		$img_b.width = w;
	ref_c.height = $img_a.height =
		$img_b.height = h;

	const ref_ctx =
		ref_c.getContext('2d');
	ref_ctx.drawImage($ref, 0, 0, w, h);

	const ref_id =
		ref_ctx.getImageData(0, 0, w, h);
	const ref_d = ref_id.data;

	const getBlack = ctx => {
		const id =
			ctx_a.createImageData(1,1);
		const d = id.data;
		d[0] = d[1] = d[2] = 0;
		d[3] = 255;
		return id;
	};

	const ctx_a = $img_a.getContext('2d');
	let black_a = getBlack(ctx_a);
	const ctx_b = $img_b.getContext('2d');
	let black_b = getBlack(ctx_b);

	let r = 0;
	for (let y = 0; y < h; ++y) {
		for (let x = 0; x < w; x += 2) {
			
	let v = 0;
	for (let i = 0; i < 2; ++i) {
		let vv = 0;
		for (let j = 0; j < 3; ++j) {
			vv += ref_d[r++];
		}
		v += vv * ref_d[r++] / 255;
	}

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

	if (Math.random() < 0.5) {
		putPixel(x, x + 1, y, v);
	} else {
		putPixel(x + 1, x, y, v);
	}
;
		}
	}
;
		}
	);

