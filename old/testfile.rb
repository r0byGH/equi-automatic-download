load 'properties.rb'
  
p = load_properties("equi.properties")
puts p["data_start"]
puts p["data_end"]
puts p["download_dir"]
puts p["username"]
puts p["password"]
