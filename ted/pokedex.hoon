/-  spider
/+  strandio
=,  strand=strand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
=+  !<([~ arg=@t] arg)
=/  base-url  "https://pokeapi.co/api/v2/pokemon/"
=/  url  (weld base-url (trip arg))
;<  pokeinfo=json  bind:m  (fetch-json:strandio url)
(pure:m !>(pokeinfo))
