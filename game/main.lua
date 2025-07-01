function love.load()
end

function love.update()
	print("Hello!")
end

function love.draw()
	love.graphics.print("Hello, World!", 400, 300)
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	elseif key == "space" then
		print("Space key pressed!")
	end
end
