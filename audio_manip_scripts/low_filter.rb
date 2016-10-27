in_path, out_path, delta = 3.times.map { ARGV.shift }

# delta here means a number like 50%, meaning the percentage to apply the filter

`sox #{in_path} #{out_path} lowpass #{delta}`
