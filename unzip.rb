require 'rubygems'
require 'zip'

load 'properties.rb'
p = load_properties("equi.properties")

data_start = p["data_start"]
data_end = p["data_end"]
search_folder = p["download_dir"]
search_folder += "/" + data_start.gsub("\/", "\-")  + "_" +  data_end.gsub("\/", "\-")  

def unzip_file (file, destination)
 Zip::File.open(file) { |zip_file|
   zip_file.each { |f|
     f_path=File.join(destination, f.name)
     FileUtils.mkdir_p(File.dirname(f_path))
     zip_file.extract(f, f_path) unless File.exist?(f_path)
   }
  }
  end

root_dir = search_folder
FGtxtfile = search_folder + "/risconet_FG.txt"
GEtxtfile = search_folder + "/risconet_GE.txt"

#unzip_file(zipfile_name, zip_dir)

#OPERAZIONI POST SCARICO
#uncompress di tutti i files
Dir.glob("#{root_dir}/*") do |d|

  if File.directory?(d)

	Dir.glob("#{d}/*.zip") do |f|
		if File.file?(f)
			unzip_file(f, d)
		end
	end
  end
  
end

#crea unico file di testo
#concatena i files
File.open( FGtxtfile, "w" ){ |f_out|
	File.open( GEtxtfile, "w" ){ |f2_out|
		Dir.glob("#{root_dir}/*") do |d|
		  if File.directory?(d)
			Dir.glob("#{d}/*.txt") do |f|
				if File.file?(f)
						File.open(f){|f_in|
						  f_in.each {|f_str| 
							f_out.puts(f_str) unless f_str.match("^Codice Agente della Riscossione;") || f_str.match("^...;.....;B;999") || f_str.match("^048")   
							f2_out.puts(f_str) unless f_str.match("^Codice Agente della Riscossione;") || f_str.match("^...;.....;B;999") || ! f_str.match("^048")      
							}
						}
				end
			end
		  end
		end
	}
}



