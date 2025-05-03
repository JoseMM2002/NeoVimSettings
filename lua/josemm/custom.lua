--- Establece el ancho de tabulación (tabstop, shiftwidth, softtabstop) a un valor específico.
--- @param width integer El ancho deseado para la tabulación.
function SetTabWidth(width)
	-- Validación básica de la entrada
	if type(width) ~= "number" or width <= 0 then
		vim.notify("Error: setTabWidth requires a positive number argument.", vim.log.levels.ERROR)
		return -- Salir si la entrada no es válida
	end

	-- Asegurarse de que sea un entero (aunque Lua es flexible)
	local int_width = math.floor(width)

	-- Establecer las opciones usando la API moderna vim.opt
	vim.opt.tabstop = int_width
	vim.opt.shiftwidth = int_width
	vim.opt.softtabstop = int_width -- Mantener sincronizado para consistencia

	-- Mensaje de confirmación (opcional)
	vim.notify(string.format("Tab width set to %d", int_width), vim.log.levels.INFO)
end
