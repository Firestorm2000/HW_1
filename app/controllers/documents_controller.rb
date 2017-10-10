class DocumentsController < ApplicationController
	require 'csv'
	require 'linefit'
	def sums
		csv_file = params[:file]
		csv_path = csv_file.path
		sum = 0

		CSV.foreach(csv_path) do |row|
			sum += row[0].to_f
		end

		sum = "%.2f" % sum

		render :plain => sum
	end

	def filters
		csv_file = params[:file]
		csv_path = csv_file.path
		sum = 0

		CSV.foreach(csv_path) do |row|
			if row[2].to_f % 2 == 1
				sum += row[1].to_f
			end
		end

		sum = "%.2f" % sum

		render :plain => sum
	end

	def intervals
		nums = Array.new
		counter = 0
		counter2 = 0
		limit = 0
		max = 0

		CSV.foreach(params[:file].path) do |row|
			nums.push(row[0].to_f)
		end

		while nums.size - counter >= 30
			counter2 = counter
			limit = counter2 + 30
			sum = 0

			while counter2 < limit
				sum += nums[counter2]
				counter2 += 1
			end

			if sum > max then max = sum end

			counter += 1
		end

		max = "%.2f" % max

		render :plain => max
	end

	def lin_regressions
		x_data = []
		y_data = []

		CSV.foreach(params[:file].path) do |row|
			x_data.push([row[0].to_f, row[1].to_f])
			y_data.push(row[2].to_f)
		end

		lineFit = LineFit.new
		lineFit.setData(x_data,y_data)
		intercept, slope = lineFit.coefficients

		intercept = "%.6f" % intercept
		slope = "%.6f" % slope

		render :plain => "#{intercept},#{slope}"
	end
end
