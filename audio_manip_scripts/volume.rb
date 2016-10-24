delta, in_path, out_path = 3.times.map { ARGV.shift }
`sox -v #{delta} #{in_path} #{out_path}`
