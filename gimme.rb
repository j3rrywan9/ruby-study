def gimme
	if block_given?
		yield
	else
		puts "I'm blockless!"
	end
end

gimme {puts "I'm with a block."}
gimme

