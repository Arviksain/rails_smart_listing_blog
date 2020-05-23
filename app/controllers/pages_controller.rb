class PagesController < ApplicationController
	def about
		@title = 'About us';
		@content = 'I am Arvik';
	end

end
