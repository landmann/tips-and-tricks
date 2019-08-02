// Configure CodeMirror Keymap jk, etc.
require([
  'nbextensions/vim_binding/vim_binding',   // depends your installation
], function() {
  // Map jk to <Esc>
  CodeMirror.Vim.map("jk", "<Esc>", "insert");
  // Swap j/k and gj/gk (Note that <Plug> mappings)
  CodeMirror.Vim.map("j", "<Plug>(vim-binding-gj)", "normal");
  CodeMirror.Vim.map("k", "<Plug>(vim-binding-gk)", "normal");
  CodeMirror.Vim.map("gj", "<Plug>(vim-binding-j)", "normal");
  CodeMirror.Vim.map("gk", "<Plug>(vim-binding-k)", "normal");
});

// Move around in Insert mode with Ctrl-h/j/k/l
require([
  'nbextensions/vim_binding/vim_binding',
], function() {
  // Use Ctrl-h/l/j/k to move around in Insert mode
  CodeMirror.Vim.defineAction('[i]<C-h>', function(cm) {
    var head = cm.getCursor();
    CodeMirror.Vim.handleKey(cm, '<Esc>');
    if (head.ch <= 1) {
      CodeMirror.Vim.handleKey(cm, 'i');
    } else {
      CodeMirror.Vim.handleKey(cm, 'h');
      CodeMirror.Vim.handleKey(cm, 'a');
    }
  });
  CodeMirror.Vim.defineAction('[i]<C-l>', function(cm) {
    var head = cm.getCursor();
    CodeMirror.Vim.handleKey(cm, '<Esc>');
    if (head.ch === 0) {
      CodeMirror.Vim.handleKey(cm, 'a');
    } else {
      CodeMirror.Vim.handleKey(cm, 'l');
      CodeMirror.Vim.handleKey(cm, 'a');
    }
  });
  CodeMirror.Vim.mapCommand("<C-h>", "action", "[i]<C-h>", {}, { "context": "insert" });
  CodeMirror.Vim.mapCommand("<C-l>", "action", "[i]<C-l>", {}, { "context": "insert" });
  CodeMirror.Vim.map("<C-j>", "<Esc>ja", "insert");
  CodeMirror.Vim.map("<C-k>", "<Esc>ka", "insert");

  // Use Ctrl-h/l/j/k to move around in Normal mode
  // otherwise it would trigger browser shortcuts
  CodeMirror.Vim.map("<C-h>", "h", "normal");
  CodeMirror.Vim.map("<C-l>", "l", "normal");
  // Updated for v2.0.0
  // While jupyter-vim-binding use <C-j>/<C-k> to move around cell
  // The following key mappings should not be defined
  //CodeMirror.Vim.map("<C-j>", "j", "normal");
  //CodeMirror.Vim.map("<C-k>", "k", "normal");
});

// Change cell types with Ctrl-#
require([
  'nbextensions/vim_binding/vim_binding',
  'base/js/namespace',
], function(vim_binding, ns) {
  // Add post callback
  vim_binding.on_ready_callbacks.push(function(){
    var km = ns.keyboard_manager;
    
    // Allow Ctrl-1 to change the cell mode into Code in Vim normal mode
    km.edit_shortcuts.add_shortcut('ctrl-1', 'vim-binding:change-cell-to-code', true);
    // Allow Ctrl-2 to change the cell mode into Markdown in Vim normal mode
    km.edit_shortcuts.add_shortcut('ctrl-2', 'vim-binding:change-cell-to-markdown', true);
    // Allow Ctrl-3 to change the cell mode into Raw in Vim normal mode
    km.edit_shortcuts.add_shortcut('ctrl-3', 'vim-binding:change-cell-to-raw', true);
    
    // Update Help
    km.edit_shortcuts.events.trigger('rebuild.QuickHelp');
  });
});

// using :q to leave Vim mode and re-enter Jupyter mode
require([
	'base/js/namespace',
	'codemirror/keymap/vim',
	'nbextensions/vim_binding/vim_binding'
], function(ns) {
	CodeMirror.Vim.defineEx("quit", "q", function(cm){
		ns.notebook.command_mode();
		ns.notebook.focus_cell();
	});
});
