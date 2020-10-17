
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

	const refresh = () => {
		
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


	};
	refresh();

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
 {
	
	let mouse_down = false;
	let x = 0;
	let y = 0;

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
;
}  {
	$('#upload').addEventListener('change', function () {
		if (this.files && this.files[0]) {
			$ref.onload = refresh;
			$ref.src = URL.createObjectURL(this.files[0]);
		}
	});
} ;
		}
	);

