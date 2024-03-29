Class constructor($target; $pattern : Text)
	
	This:C1470._target:=""
	This:C1470._pattern:=""
	This:C1470.time:=0
	This:C1470.success:=True:C214
	This:C1470.matches:=Null:C1517
	This:C1470.errors:=New collection:C1472
	
	If (Count parameters:C259>=1)
		
		This:C1470.setTarget($target)
		
		If (Count parameters:C259>=2)
			
			This:C1470.setPattern($pattern)
			
		End if 
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function get target() : Text
	
	return This:C1470._target
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function set target($target)
	
	This:C1470._setTarget($target)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function get pattern() : Text
	
	return This:C1470._pattern
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function set pattern($pattern : Text)
	
	This:C1470._pattern:=$pattern
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function get lastError() : Object
	
	If (This:C1470.errors.length>0)
		
		return This:C1470.errors[This:C1470.errors.length-1]
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Sets the string where will be perform the search.
	// Could be a text or a disk file
Function setTarget($target) : cs:C1710.regex
	
	This:C1470._setTarget($target)
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Sets the regular expression to use.
Function setPattern($pattern : Text) : cs:C1710.regex
	
	This:C1470._pattern:=$pattern
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function match($start; $all : Boolean) : Boolean
	
	var $methodCalledOnError : Text
	var $match : Boolean
	var $begin; $i; $index : Integer
	var $item : Object
	
	ARRAY LONGINT:C221($positions; 0)
	ARRAY LONGINT:C221($lengths; 0)
	
	$begin:=Milliseconds:C459
	
	If (Count parameters:C259>=1)
		
		If (Value type:C1509($start)=Is boolean:K8:9)
			
			$all:=$start
			$start:=1
			
		Else 
			
			$start:=Num:C11($start)
			
		End if 
		
	Else 
		
		$start:=1  // Start the search with the first character
		
	End if 
	
	This:C1470._init()
	
	$methodCalledOnError:=This:C1470._errorCatch()
	
	Repeat 
		
		ERROR:=0
		
		$match:=Match regex:C1019(This:C1470._pattern; This:C1470._target; $start; $positions; $lengths)
		
		If (ERROR=0)
			
			If ($match)
				
				This:C1470.success:=True:C214
				
				For ($i; 0; Size of array:C274($positions); 1)
					
					This:C1470.matches.push(New object:C1471(\
						"index"; $index; \
						"data"; Substring:C12(This:C1470._target; $positions{$i}; $lengths{$i}); \
						"position"; $positions{$i}; \
						"length"; $lengths{$i}))
					
					If ($lengths{$i}=0)
						
						$match:=($i>0)
						
						If ($match)
							
							$match:=($positions{$i}#$positions{$i-1})
							
						End if 
					End if 
					
					If ($positions{$i}>0)
						
						$start:=$positions{$i}+$lengths{$i}
						
					End if 
				End for 
				
				$match:=$all  // Stop after the first match ?
				
			End if 
			
			$index+=1
			
		Else 
			
			This:C1470._pushError(Current method name:C684; ERROR; "Error while parsing pattern \""+This:C1470._pattern+"\"")
			
		End if 
	Until (Not:C34($match))
	
	This:C1470._errorCatch($methodCalledOnError)
	
	This:C1470.time:=Milliseconds:C459-$begin
	
	return This:C1470.success
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Count the words in a string
Function countWords($target : Text) : Integer
	
	This:C1470.target:=$target || This:C1470.target
	This:C1470.pattern:="(?mi-s)((?:[^[:punct:]\\$\\s[:cntrl:]'‘’]+[’'][^[:punct:]\\$\\s[:cntrl:]'‘’]+)|[^[:punct:]\\s[:cntrl:]'‘’\\$]+)"
	
	return This:C1470.extract().length
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Validate an email address
Function validateMail($target : Text) : Boolean
	
	This:C1470.target:=$target || This:C1470.target
	This:C1470.pattern:="^([-a-zA-Z0-9_]+(?:\\.[-a-zA-Z0-9_]+)*)(?:@)([-a-zA-Z0-9\\._]+(?:\\.[a-zA-Z0-9]{2,}"+")+)$"
	
	return This:C1470.match()
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function extract($groups) : Collection
	
	var $methodCalledOnError : Text
	var $match : Boolean
	var $begin; $current; $groupIndex; $i; $index; $indx; $start : Integer
	var $v
	
	ARRAY LONGINT:C221($lengths; 0)
	ARRAY LONGINT:C221($positions; 0)
	
	$begin:=Milliseconds:C459
	
	$start:=1
	
	This:C1470._init()
	
	Case of 
			
			//___________________________________
		: ($groups=Null:C1517)
			
			$groups:=New collection:C1472
			
			//___________________________________
		: (Value type:C1509($groups)=Is longint:K8:6)\
			 | (Value type:C1509($groups)=Is real:K8:4)
			
			$groups:=New collection:C1472(String:C10($groups))
			
			//___________________________________
		: (Value type:C1509($groups)=Is text:K8:3)
			
			$groups:=Split string:C1554($groups; " ")
			
			//___________________________________
		: (Value type:C1509($groups)=Is collection:K8:32)
			
			// Transform into text if necessary
			For each ($v; $groups)
				
				$groups[$i]:=String:C10($v)
				$i+=1
				
			End for each 
			
			//___________________________________
		Else 
			
			// Argument types are incompatible.
			This:C1470._pushError(Current method name:C684; 54; "The \"groups\" argument must be an integer, a text or a collection.")
			return 
			
			//___________________________________
	End case 
	
	$methodCalledOnError:=This:C1470._errorCatch()
	
	Repeat 
		
		ERROR:=0
		
		$match:=Match regex:C1019(This:C1470._pattern; This:C1470._target; $start; $positions; $lengths)
		
		If (ERROR=0)
			
			If ($match)
				
				This:C1470.success:=True:C214
				
				$current:=0
				
				For ($i; 0; Size of array:C274($positions); 1)
					
					$groupIndex:=$groups.length>0 ? $groups.indexOf(String:C10($current)) : $current
					
					If ($groupIndex>=0)
						
						If ($i>0)\
							 | ($index=0)
							
							If (This:C1470.matches.query("data = :1 & pos = :2"; Substring:C12(This:C1470._target; $positions{$i}; $lengths{$i}); $positions{$i}).pop()=Null:C1517)
								
								This:C1470.matches.push(New object:C1471(\
									"index"; $indx; \
									"data"; Substring:C12(This:C1470._target; $positions{$i}; $lengths{$i}); \
									"pos"; $positions{$i}; \
									"len"; $lengths{$i}))
								
								$indx+=1
								
							End if 
						End if 
					End if 
					
					If ($positions{$i}>0)
						
						$start:=$positions{$i}+$lengths{$i}
						
					End if 
					
					$current+=1
					
				End for 
			End if 
			
		Else 
			
			This:C1470._pushError(Current method name:C684; ERROR; "Error while parsing pattern \""+This:C1470._pattern+"\"")
			
		End if 
		
		$index+=1
		
	Until (Not:C34($match))
	
	This:C1470._errorCatch($methodCalledOnError)
	
	This:C1470.time:=Milliseconds:C459-$begin
	
	return This:C1470.matches.extract("data")
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function substitute($replacement : Text; $count : Integer; $position : Integer) : Text
	
	var $backup; $methodCalledOnError; $replacedText; $subexpression : Text
	var $match : Boolean
	var $i; $sub; $index; $start : Integer
	var $o : Object
	
	ARRAY LONGINT:C221($lengths; 0)
	ARRAY LONGINT:C221($positions; 0)
	
	// Todo:Manage count and position
	
	$start:=1
	$backup:=$replacement
	
	This:C1470._init()
	
	$methodCalledOnError:=This:C1470._errorCatch()
	
	Repeat 
		
		$match:=Match regex:C1019(This:C1470._pattern; This:C1470._target; $start; $positions; $lengths)
		
		If (ERROR=0)
			
			If ($match)
				
				$sub:=0
				
				For ($i; 0; Size of array:C274($positions); 1)
					
					If ($positions{$i}>0)
						
						$start:=$positions{$i}+$lengths{$i}
						
					End if 
					
					If ($lengths{$i}=0)
						
						$match:=($i>0)
						
						If ($match)
							
							$match:=($positions{$i}#$positions{$i-1})
							
						End if 
					End if 
					
					If ($match)
						
						This:C1470.matches.push(New object:C1471(\
							"index"; $index; \
							"data"; Substring:C12(This:C1470._target; $positions{$i}; $lengths{$i}); \
							"pos"; $positions{$i}; \
							"len"; $lengths{$i}; \
							"_subpattern"; $sub))
						
						$sub+=1
						$index+=1
						
					Else 
						
						break
						
					End if 
				End for 
			End if 
			
		Else 
			
			This:C1470._pushError(Current method name:C684; ERROR; "Error while parsing pattern \""+This:C1470._pattern+"\"")
			return 
			
		End if 
	Until (Not:C34($match))
	
	$replacedText:=This:C1470._target
	
	If (This:C1470.matches.length>0)
		
		$index:=This:C1470.matches.length-1
		
		Repeat 
			
			$o:=This:C1470.matches[$index]
			
			If ($o._subpattern#0)
				
				$subexpression:="\\"+String:C10($o._subpattern)
				
				If (Position:C15($subexpression; $replacement)>0)
					
					$replacement:=Replace string:C233($replacement; $subexpression; $o.data)
					
				End if 
				
			Else 
				
				$replacedText:=Delete string:C232($replacedText; $o.pos; $o.len)
				$replacedText:=Insert string:C231($replacedText; $replacement; $o.pos)
				$replacement:=$backup
				
			End if 
			
			$index-=1
			
		Until ($index=-1)
		
		For each ($o; This:C1470.matches)
			
			OB REMOVE:C1226($o; "_subpattern")
			
		End for each 
	End if 
	
	This:C1470._errorCatch($methodCalledOnError)
	
	return $replacedText
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function stripTags($target : Text) : Text
	
	var $len; $pos : Integer
	
	$target:=$target || This:C1470.target
	
	$target:=Replace string:C233($target; "</p><p>"; " ")
	
	While (Match regex:C1019("(?mi-s)<[^>]*>"; $target; 1; $pos; $len))
		
		$target:=Delete string:C232($target; $pos; $len)
		
	End while 
	
	$target:=Replace string:C233($target; "\r\n"; "\n")
	$target:=Replace string:C233($target; "\n\n"; "\n")
	$target:=Replace string:C233($target; "\n"; " ")
	$target:=Replace string:C233($target; "\t"; " ")
	
	While (Position:C15("  "; $target)>0)
		
		$target:=Replace string:C233($target; "  "; " ")
		
	End while 
	
	return $target
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function _init()
	
	This:C1470.success:=False:C215
	This:C1470.matches:=New collection:C1472
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function _errorCatch($onErrCallMethod : Text)->$currentOnErrCallMethod : Text
	
	If (Count parameters:C259>=1)
		
		ON ERR CALL:C155($onErrCallMethod)
		
	Else 
		
		$currentOnErrCallMethod:=Method called on error:C704
		ON ERR CALL:C155(Formula:C1597(noError).source)
		CLEAR VARIABLE:C89(ERROR)
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function _pushError($method : Text; $code : Integer; $desc : Text)
	
	This:C1470.success:=False:C215
	This:C1470.errors.push(New object:C1471(\
		"code"; $code; \
		"method"; $method; \
		"desc"; $desc))
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function _setTarget($target)
	
	Case of 
			
			//…………………………………………………………………………………………
		: (Value type:C1509($target)=Is text:K8:3)
			
			This:C1470._target:=$target
			
			//…………………………………………………………………………………………
		: (Value type:C1509($target)=Is object:K8:27)
			
			If (OB Class:C1730($target).name="File")
				
				If ($target.exists)
					
					This:C1470._target:=$target.getText()
					
				Else 
					
					// File not found.
					This:C1470._pushError(Current method name:C684; -43; "File not found.")
					
				End if 
				
			Else 
				
				// Argument types are incompatible.
				This:C1470._pushError(Current method name:C684; 54; "The \"target\" object is not a 4D.File.")
				
			End if 
			
			//…………………………………………………………………………………………
		: (Value type:C1509($target)=Is BLOB:K8:12)
			
			This:C1470._target:=Convert to text:C1012($target; "UTF-8")
			This:C1470.success:=Bool:C1537(OK)
			
			//…………………………………………………………………………………………
		Else 
			
			// Argument types are incompatible.
			This:C1470._pushError(Current method name:C684; 54; "The \"target\" argument  must be Text, a Blob or 4D.File.")
			
			//…………………………………………………………………………………………
	End case 