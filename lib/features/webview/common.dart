String jsToExecute = """
  document.body.style.backgroundColor = "red";
  document.getElementById("cfw-side-cart-floating-button")  .remove();
  let children = document.querySelectorAll("body *");
  for(let child of children) {
      let classes = child.classList;
      if(classes.toString().trim() === `fusion-fullwidth fullwidth-box fusion-builder-row-3 fusion-flex-container nonhundred-percent-fullwidth non-hundred-percent-height-scrolling fusion-no-large-visibility fusion-custom-z-index`) {
          child.remove();
      }
      if(classes.toString().trim() === `fusion-fullwidth fullwidth-box fusion-builder-row-1 fusion-flex-container has-pattern-background has-mask-background hundred-percent-fullwidth non-hundred-percent-height-scrolling fusion-no-small-visibility fusion-no-medium-visibility fusion-custom-z-index`) {
          child.remove();
      }
      if(classes.toString().trim() === `fusion-menu fusion-custom-menu fusion-menu-element-list`) {
          child.remove();
      }
      if(classes.toString().trim() === `fusion-tb-footer fusion-footer`) {
          child.remove();
      }
      if(child.tagName.toLowerCase() === 'iframe') {
          child.remove();
      }
      if(classes.toString().trim() === `fusion-fullwidth fullwidth-box fusion-builder-row-3 fusion-flex-container nonhundred-percent-fullwidth non-hundred-percent-height-scrolling fusion-no-large-visibility fusion-custom-z-index`) {
          child.remove();
      }
      if(classes.toString().trim() === `fusion-fullwidth fullwidth-box fusion-builder-row-2 fusion-flex-container nonhundred-percent-fullwidth non-hundred-percent-height-scrolling fusion-no-large-visibility fusion-custom-z-index`) {
          child.remove();
      }
      if(classes.toString() === 'fb_dialog  fb_dialog_advanced') {
        child.remove();
      }
  }
""";