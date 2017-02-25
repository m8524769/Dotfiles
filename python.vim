" 函数名高亮
syn match    pyCustomParen    "("
syn match    pyCustomFunc     "\w\+\s*(\@=" contains=pyCustomParen

hi pyCustomFunc guifg=#66D9EF 

" 参数高亮
syn match    pyCustomColon    "):"
syn match    pyCustomArgu     "\w\+):\@=" contains=pyCustomColon

hi pyCustomArgu guifg=#FD971F 
