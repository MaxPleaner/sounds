in_file, out_file, delta = 3.times.map { ARGV.shift }

# delta is a percentage, to change speed

`sox #{in_file} #{out_file} speed #{delta}`
