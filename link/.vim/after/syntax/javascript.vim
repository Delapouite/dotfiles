syntax region  javaScriptStringD start=+`+  skip=+\\\\\|\\`+  end=+`\|$+	contains=javaScriptSpecial,@htmlPreproc
syntax keyword javaScriptIdentifier const
syntax keyword javaScriptStatement yield
syntax keyword javaScriptReserved as from

syntax keyword jsConcealClass     class     conceal cchar=Ć
syntax keyword jsConcealFunction  function  conceal cchar=ƒ
syntax keyword jsConcealNaN       NaN       conceal cchar=ℕ
syntax keyword jsConcealNull      null      conceal cchar=ø
syntax keyword jsConcealPrototype prototype conceal cchar=∷
syntax keyword jsConcealReturn    return    conceal cchar=⇚
syntax keyword jsConcealThis      this      conceal cchar=@
syntax keyword jsConcealThrow     throw     conceal cchar=⇑
syntax keyword jsConcealUndefined undefined conceal cchar=¿
syntax match   jsConcealSpread    /\.\.\./  conceal cchar=…
