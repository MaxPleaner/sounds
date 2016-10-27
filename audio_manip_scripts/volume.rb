in_path, out_path, delta = 3.times.map { ARGV.shift }

# delta here is a number of dB to set the volume to

`sox #{in_path} #{out_path} vol #{delta} dB`
