-- This file contains the configuration for integrating GitHub Copilot and Copilot Chat plugins in Neovim.

-- Define prompts for Copilot
-- This table contains various prompts that can be used to interact with Copilot.
local prompts = {
	Explain = "Provide a detailed explanation of the functionality and purpose of this code.", -- Detailed explanation of code functionality and purpose
	Review = "Conduct a thorough review of this code to identify potential issues or areas for improvement.", -- Thorough code review for issues and improvements
	Tests = "Generate comprehensive unit tests to validate the functionality of this code.", -- Generate comprehensive unit tests to validate functionality
	Refactor = "Refactor this code to improve its structure, readability, and maintainability.", -- Refactor code for better structure, readability, and maintainability
	FixCode = "Identify and resolve any issues or bugs present in this code.", -- Identify and resolve code issues or bugs
	FixError = "Locate and fix the specific error in this code, ensuring it runs correctly.", -- Locate and fix specific code errors
	BetterNamings = "Suggest more descriptive and meaningful names for variables and functions in this code.", -- Suggest descriptive and meaningful names for variables and functions
	Documentation = "Create detailed and clear documentation to explain the usage and functionality of this code.", -- Create detailed and clear code documentation
	Summarize = "Provide a concise summary of the purpose and functionality of this code.", -- Concisely summarize code purpose and functionality
	Optimize = "Optimize this code to enhance its performance and efficiency.", -- Optimize code for better performance and efficiency
	Convert = "Translate this code into another programming language while maintaining its functionality.", -- Translate code to another programming language while maintaining functionality
	Debug = "Debug this code to identify, diagnose, and fix any issues or errors.", -- Debug code to identify, diagnose, and fix issues or errors
	Enhance = "Add new features or improvements to this code to extend its capabilities.", -- Add new features or improvements to extend code capabilities
	Analyze = "Analyze this code to identify potential improvements, inefficiencies, or issues.", -- Analyze code for potential improvements, inefficiencies, or issues
	ExplainConcept = "Explain the underlying concept, algorithm, or logic used in this code.", -- Explain underlying concept, algorithm, or logic in code
	GenerateExamples = "Create example usage scenarios to demonstrate how this code can be used.", -- Create example usage scenarios to demonstrate code usage
	Compare = "Compare this code with another implementation to highlight differences and similarities.", -- Compare code with another implementation to highlight differences and similarities
	CheckSecurity = "Evaluate this code for any security vulnerabilities or risks.", -- Evaluate code for security vulnerabilities or risks
	GenerateComments = "Insert meaningful and informative comments throughout this code to explain its logic.", -- Insert meaningful and informative comments to explain code logic
}

return {
	{
		"github/copilot.vim",
		config = function()
			vim.keymap.set("i", "<C-L>", "<Plug>(copilot-accept-word)")
			vim.keymap.set("i", "<C-K>", "<Plug>(copilot-accept-line)")
			vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
			})
			vim.g.copilot_no_tab_map = true
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim", -- Load the Copilot Chat plugin
		config = function()
			require("CopilotChat").setup({
				mappings = {
					complete = {
						insert = "<Tab>",
					},
					close = {
						normal = "q",
						insert = "",
					},
					show_diff = {
						normal = "cd",
						full_diff = true,
					},
				},
				prompts = prompts,
				system_prompt = "Hola soy Jose, soy un desarrollador de software mid, mi trabajo principal es desarrollar aplicaciones web en Vue y React en el frontend, en el backend soy experto en Express y me gusta Actix en el lenguaje Rust, afuera de mi trabajo principal me gusta hacer proyectos en Rust y Zig, a veces uso Go y me gusta aprender nuevos paradigmas de programacion y tambien nuevos lenguajes",
				model = "gpt-4o",
				answer_header = "~~ Copilot Chat ~~ ",
				highlight_headers = false,
				separator = "---",
				error_header = "> [!ERROR] Error",
				window = {
					layout = "vertical", -- 'vertical', 'horizontal', 'float', 'replace'
					width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
					height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
					-- Options below only apply to floating windows
					relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
					border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
					row = nil, -- row position of the window, default is centered
					col = nil, -- column position of the window, default is centered
					title = "Copilot Chat", -- title of chat window
					footer = nil, -- footer of chat window
					zindex = 1, -- determines if window is on top or below other floating windows
				},
			})
			local chat = require("CopilotChat")
			vim.keymap.set({ "n", "v" }, "<leader>occ", function()
				chat.open()
			end)
			vim.keymap.set("n", "<leader>tcc", function()
				chat.toggle()
			end)
			vim.keymap.set("n", "<leader>ccq", function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					chat.ask(input, { selection = require("CopilotChat.select").buffer })
				end
			end)
			vim.keymap.set("n", "<leader>ccp", function()
				local actions = require("CopilotChat.actions")
				require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
			end)
		end,
	},
}
