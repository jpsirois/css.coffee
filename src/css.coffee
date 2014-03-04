###!
Simple CSS rules manipulation via JS
Source: https://github.com/jpsirois/css.coffee

Usage Example:
selector = ".foobar"
properties = "display: none"
CSSRuleIndex = CSS.insertRule({selector:selector, properties:properties})
CSS.deleteRule(CSSRuleIndex)
CSS.replaceRule({rule:CSSRuleIndex, selector:selector, properties:properties})
###

@JCSS =
  insertRule: (args) ->
    ss = document.styleSheets
    # Select the last Stylesheet
    s = ss[ss.length - 1]
    if s.insertRule
      # Set the CSS Rule index to be the last of the last Stylesheet
      ruleIndex = s.cssRules.length
      i = s.insertRule(args.selector + " {" + args.properties + "}", ruleIndex)
    else # Fallback for legacy browser
      i = s.addRule(args.selector, args.properties)
    i
  deleteRule: ->
    rule = arguments[0]
    ss = document.styleSheets
    # Select the last Stylesheet
    s = ss[ss.length - 1]
    if s.insertRule
      s.deleteRule rule
    else # Fallback for legacy browser
      s.removeRule rule
    return
  replaceRule: (args) ->
    @deleteRule args.rule
    @insertRule
      selector: args.selector
      properties: args.properties
