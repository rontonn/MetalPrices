class MetalsController < ApplicationController

require 'nokogiri' 
require 'open-uri'
	
	 def home
 	end

	def create
		if Metal.count != 0 then Metal.destroy_all end
		@metal = Metal.new(params[:metal])

		regex2 = /\s+/

		page_url = "http://www.lme.com/"
		page = Nokogiri::HTML(open(page_url))

		@metal.date = Time.new.strftime("%Y-%m-%d %H:%M:%S") + ": data from LME"
		@metal.save
		for i in 0..10 do
		@metal = Metal.new(params[:metal])
		@metal.name = page.css("table#MD_current_official_prices_aluminium tbody tr th a")[i].text
		@metal.price = page.css("table#MD_current_official_prices_aluminium tbody tr td")[i].text
		if (@metal.name == "Copper")
			@metal.name += "(Медь)"
		end

		if (@metal.name == "Lead")
			@metal.name += "(Свинец)"
		end
		if (@metal.name == "Tin")
			@metal.name += "(Олово)"
		end


		@metal.save
		end
		@metal = Metal.all
		
	end

	def show
		@metal = Metal.find(params[:id])
	end

	def index
		@metal = Metal.all
	end
end
