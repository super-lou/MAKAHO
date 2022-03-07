searchHTML = HTML("
.selectize-input.items.not-full.has-options:before {
 content: '\\e003';
 font-family: \"Glyphicons Halflings\";
 line-height: 2;
 display: block;
 position: absolute;
 top: 0;
 left: 0;
 padding: 0 4px;
 font-weight:900;
 }
  
  .selectize-input.items.not-full.has-options {
    padding-left: 24px;
  }
 
 .selectize-input.items.not-full.has-options.has-items {
    padding-left: 0px;
 }
 
  .selectize-input.items.not-full.has-options .item:first-child {
      margin-left: 20px;
 }
")


panelButtonCSS =
    "color: #fff; background-color: rgba(35, 35, 35, 0.8); border-color: transparent"
