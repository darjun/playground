pub fn public_function() {
	println!("called rary's `public_function()`");
}

fn private_function() {
	println!("called rary's `private_function()`");
}

pub fn indirect_access() {
	print!("called rary's `indrect_access()`, that\n> ");

	private_function();
}