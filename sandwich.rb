#! ruby

def get_info(uuid)
  low, mid, high, clock, mac = uuid.split("-")

  save, one, two, three = high.split("")
  high = one + two + three
  hex = high + mid + low

  [hex.to_i(16), clock, mac, save]
end

def get_uuid(timestamp, clock, mac, save)
  hex = timestamp.to_s(16)
  high = hex[0..2]
  mid = hex[3..6]
  low = hex[7..]
  "#{ low }-#{ mid }-#{ save }#{ high }-#{ clock }-#{ mac }"
end


def generate_uuids_file(uuid, uuid2, filename: "uuids_list.txt")
  t1, clock, mac, save = get_info(uuid)
  t2, _, _, _ = get_info(uuid2)

  uuids = (t1..t2).to_a.map do |timestamp|
    get_uuid(timestamp, clock, mac, save)
  end

  print "#{ uuids.size } found > #{ filename }\n"
  File.open(filename, "w+") { |f| f.write(uuids.join("\n")) }
  nil
end

def print_help()
  print "Usage:\n"
  print "  ./sandwich.rb <UUID1> <UUID2> [-o <FILEPATH>] [-m \"<MACHINE1>,<MACHINE2>,<MACHINE3>\"]\n"

  exit(0)
end

def get_filename(args)
  if args[2] == "-o"
    return args[3]
  elsif args[4] == "-o"
    return args[5]
  end
end

def get_machines(args)
  if args[2] == "-m"
    return args[3].split(",").map(&:strip)
  elsif args[4] == "-m"
    return args[5].split(",").map(&:strip)
  end
end

def parse_args(args)
  [get_filename(args), get_machines(args)]
end

case ARGV.size
when 2
  generate_uuids_file(ARGV[0], ARGV[1])
when 4
  filename, machines = parse_args(ARGV)
  if filename
    generate_uuids_file(ARGV[0], ARGV[1], filename)
  elsif machines
    machines.each do |machine|
      generate_uuids_file("#{ARGV[0][0..12]}-#{machine}", "#{ARGV[1][0..12]}-#{machine}", filename: "#{machine}.txt")
    end
  else
    print_help()
  end
when 6
  filename, machines = parse_args(ARGV)
  print_help() unless filename && machines

  machines.each do |machine|
    generate_uuids_file("#{ARGV[0][0..12]}-#{machine}", "#{ARGV[1][0..12]}-#{machine}", filename: "#{machine}-#{filename}")
  end
else
  print_help()
end
