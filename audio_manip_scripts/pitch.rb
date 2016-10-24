in_file, out_file, delta = 3.times.map { ARGV.shift }

`sox #{in_file} #{out_file} speed #{delta}`
